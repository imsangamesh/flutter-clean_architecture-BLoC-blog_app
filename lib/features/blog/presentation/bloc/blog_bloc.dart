import 'dart:io';

import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(const BlogInitial()) {
    //
    on<BlogEvent>((event, emit) => emit(const BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetch>(_onBlogsFetch);
  }

  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (_) => emit(const BlogUploadSuccess()),
    );
  }

  Future<void> _onBlogsFetch(BlogFetch event, Emitter<BlogState> emit) async {
    final result = await _getAllBlogs();

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogFetchSuccess(blogs)),
    );
  }
}
