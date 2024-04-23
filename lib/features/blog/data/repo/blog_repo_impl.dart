import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_src.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_src.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepoImpl implements BlogRepo {
  BlogRepoImpl({
    required this.remoteDataSrc,
    required this.uuid,
    required this.checker,
    required this.localDataSrc,
  });

  final BlogRemoteDataSrc remoteDataSrc;
  final Uuid uuid;
  final ConnectionChecker checker;
  final BlogLocalDataSrc localDataSrc;

  @override
  FutureEither<void> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    if (!await checker.isConnected) {
      return const Left(Failure('No Internet Connection!'));
    }

    try {
      final blog = BlogModel(
        id: uuid.v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      await remoteDataSrc.uploadBlog(blog: blog, imageFile: image);
      return right(null);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  FutureEither<List<Blog>> getAllBlogs() async {
    try {
      if (!await checker.isConnected) {
        final blogs = await localDataSrc.loadLocalBlogs();
        return right(blogs);
      }

      final blogs = await remoteDataSrc.getAllBlog();
      await localDataSrc.uploadLocalBlogs(blogs);

      return right(blogs);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    }
  }
}
