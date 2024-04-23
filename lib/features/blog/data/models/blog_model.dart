import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

  factory BlogModel.fromMap(DataMap map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      topics: (map['topics'] as List).map((e) => e.toString()).toList(),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  DataMap toMap() => {
        'id': id,
        'posterId': posterId,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'topics': topics,
        'updatedAt': updatedAt.millisecondsSinceEpoch,
      };

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) =>
      BlogModel(
        id: id ?? this.id,
        posterId: posterId ?? this.posterId,
        title: title ?? this.title,
        content: content ?? this.content,
        imageUrl: imageUrl ?? this.imageUrl,
        topics: topics ?? this.topics,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
