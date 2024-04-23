import 'dart:io';

import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/core/services/usecases.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repo.dart';

class UploadBlog implements UseCaseWithParams<void, UploadBlogParams> {
  UploadBlog(this.repo);

  final BlogRepo repo;

  @override
  FutureVoid call(UploadBlogParams params) => repo.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics,
      );
}

class UploadBlogParams {
  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });

  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
}
