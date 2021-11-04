// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as String?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    createAt: json['createAt'] as String?,
    author: json['author'] as String?,
    comments: json['comments'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createAt': instance.createAt,
      'author': instance.author,
      'comments': instance.comments,
    };
