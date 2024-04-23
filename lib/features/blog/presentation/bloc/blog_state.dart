part of 'blog_bloc.dart';

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {
  const BlogInitial();
}

final class BlogLoading extends BlogState {
  const BlogLoading();
}

final class BlogUploadSuccess extends BlogState {
  const BlogUploadSuccess();
}

final class BlogFetchSuccess extends BlogState {
  const BlogFetchSuccess(this.blogs);
  final List<Blog> blogs;
}

final class BlogFailure extends BlogState {
  const BlogFailure(this.message);
  final String message;
}
