import 'dart:io';

import 'package:blog_app/core/apis/storage_api_provider.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class BlogRemoteDataSrc {
  Future<void> uploadBlog({
    required BlogModel blog,
    required File imageFile,
  });
  Future<List<BlogModel>> getAllBlog();
}

class BlogRemoteDataSrcImpl implements BlogRemoteDataSrc {
  BlogRemoteDataSrcImpl({required this.fire, required this.storageApi});

  final FirebaseFirestore fire;
  final FireStorageApi storageApi;

  @override
  Future<void> uploadBlog({
    required BlogModel blog,
    required File imageFile,
  }) async {
    try {
      final imageUrl = await storageApi.storeFile(
        path: 'blogs',
        id: blog.id,
        file: imageFile,
      );

      if (imageUrl == null) {
        throw const ApiException('Image uploading failed, please try again!');
      }

      blog = blog.copyWith(imageUrl: imageUrl); // updating the imageUrl
      await fire.collection(FireKeys.blogs).doc(blog.id).set(blog.toMap());
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogSnap = await fire.collection(FireKeys.blogs).get();
      final blogs =
          blogSnap.docs.map((e) => BlogModel.fromMap(e.data())).toList();

      // combining username with posterId
      for (var i = 0; i < blogs.length; i++) {
        final user =
            await fire.collection(FireKeys.users).doc(blogs[i].posterId).get();
        final name = (user.data()!)['name'];
        blogs[i] = blogs[i].copyWith(posterId: '${blogs[i].posterId} $name');
      }

      return blogs;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
