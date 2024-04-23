import 'dart:io';

import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';

abstract interface class BlogRepo {
  FutureEither<void> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  FutureEither<List<Blog>> getAllBlogs();
}
