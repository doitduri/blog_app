import 'package:blog_app/repositories/post_repository/models/comment.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  const Post({
    this.id,
    this.title,
    this.content,
    this.createAt,
    this.author,
    this.comments,
  });

  final String? id;
  final String? title;
  final String? content;
  final String? createAt;
  final String? author;
  final List<dynamic>? comments;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [id, title, content, comments, createAt, author];

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? createAt,
    String? author,
    List<dynamic>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createAt: createAt ?? this.createAt,
      author: author ?? this.author,
      comments: comments ?? this.comments,
    );
  }
}
