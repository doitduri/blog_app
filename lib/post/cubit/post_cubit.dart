import 'dart:convert';

import 'package:blog_app/support/utils.dart';
import 'package:blog_app/repositories/post_repository/models/comment.dart';
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:blog_app/repositories/post_repository/src/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._postRepository) : super(const PostState());
  final PostRepository _postRepository;

  // Comment : 덧글
  void addPost(title, content) async {
    DocumentReference newDoc = await _postRepository.addNewPost(title, content);

    Post newPost = Post.fromJson({
      "id": newDoc.id,
      "title": title,
      "content": content,
      "createAt": DateFormat.yMMMMd('en_US').format(DateTime.now()).toString(),
      "author": "doitduri",
    });

    emit(state.copyWith(
        posts: state.posts == null ? [newPost] : state.posts! + [newPost]));
  }

  void getAllPosts() async {
    var documents = await _postRepository.getAllPosts();

    List<Post> newPosts = [];

    // firebase에서 가져온 값들을 deserialize
    documents.docs.forEach((element) {
      newPosts.add(Post(
          id: element.id,
          title: element["title"],
          content: element["content"].toString(),
          comments: element["comments"],
          createAt: DateFormat.yMMMMd('en_US')
              .format(parseTime(element["createAt"]))
              .toString(),
          author: element["author"]));
    });

    emit(state.copyWith(posts: newPosts));
  }

  void deletePost(String postId) async {
    await _postRepository.deletePost(postId);

    List<Post> newPosts = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id != postId) {
        newPosts.add(state.posts![i]);
      }
    }

    emit(state.copyWith(posts: newPosts));
  }

  void updatePost(Post updatePost, String updateTitle, String updateContent) async {
    await _postRepository.updatePost(updatePost.id!, updateTitle, updateContent);

    List<Post> newPosts = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id != updatePost.id) {
        newPosts.add(state.posts![i]);
      } else {
        // 업데이트 하려는 문서라면
        newPosts.add(updatePost.copyWith(
          createAt: DateFormat.yMMMMd('en_US')
              .format(parseTime(updatePost.createAt))
              .toString(),
          title: updateTitle,
          content: updateContent,
        ));
      }
    }

    emit(state.copyWith(posts: newPosts));
  }

  // Comment: 덧글
  void addPostComment(Post commentPost, String content) async {
    var createAt = DateFormat.yMd().add_jm().format(DateTime.now()).toString();
    var newComment = Comment(content: content, createAt: createAt, author: "doitduri")
            .toJson();

    await _postRepository.addPostComment(commentPost, newComment);

    List<Post> newPost = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id == commentPost.id) {
        newPost.add(state.posts![i].copyWith(
            comments: state.posts![i].comments == null
                ? [newComment]
                : state.posts![i].comments! + [newComment]));
      } else {
        newPost.add(state.posts![i].copyWith());
      }
    }

    emit(state.copyWith(posts: newPost));
  }

  void deletePostComment(int index, Post commentPost, int commentId) async {

    List<dynamic> newComments = [];
    for (int i = 0; i < state.posts![index].comments!.length; i++) {
      if (i != commentId) {
        newComments.add(state.posts![index].comments![i]);
      }
    }
    await _postRepository.deletePostComment(commentPost, newComments);

    List<Post> newPost = [];
    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id == commentPost.id) {
        newPost.add(state.posts![i].copyWith(comments: newComments));
      } else {
        newPost.add(state.posts![i]);
      }
    }



    emit(state.copyWith(posts: newPost));
  }
}
