import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends Equatable {
  const Comment({
    this.id,
    this.content,
    this.createAt,
    this.author,
  });

  final String? id;
  final String? content;
  final String? createAt;
  final String? author;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  List<Object?> get props => [id, content, createAt, author];

  Comment copyWith({
    String? id,
    String? content,
    String? createAt,
    String? author,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      createAt: createAt ?? this.createAt,
      author: author ?? this.author,
    );
  }
}
