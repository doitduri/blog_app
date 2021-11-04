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
  });

  final String? id;
  final String? title;
  final String? content;
  final String? createAt;
  final String? author;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [id, title, content, createAt, author];

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? createAt,
    String? author,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createAt: createAt ?? this.createAt,
      author: author ?? this.author,
    );
  }
}
