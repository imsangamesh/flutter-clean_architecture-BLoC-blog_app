part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {
  const BlogEvent();
}

final class BlogUpload extends BlogEvent {
  const BlogUpload({
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

final class BlogFetch extends BlogEvent {
  const BlogFetch();
}
