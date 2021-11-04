import 'dart:convert';

import 'package:blog_app/home/utils.dart';
import 'package:blog_app/repositories/post_repository/models/comment.dart';
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._postingCollection) : super(const PostState());

  final CollectionReference _postingCollection;

  void addPost(title, content) async {
    var createAt = DateTime.now();

    // TODO 파이어베이스로 연동해놓았긴 했지만, 편의상 직접 계정이름을 넣어 작업함 (로그인 연동 필요 시 해당 코드 수정 필요)
    DocumentReference newDoc = await _postingCollection.add({
      "title": title,
      "content": content,
      "createAt": createAt,
      "author": "doitduri",
      "comments": []
    });

    Post newPost = Post.fromJson({
      "id": newDoc.id,
      "title": title,
      "content": content,
      "createAt": DateFormat.yMMMMd('en_US').format(createAt).toString(),
      "author": "doitduri",
    });

    emit(state.copyWith(
        posts: state.posts == null ? [newPost] : state.posts! + [newPost]));
  }

  void getAllPosts() async {
    var documents = await _postingCollection.orderBy("createAt").get();

    List<Post> newPosts = [];


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
    var documents = await _postingCollection.doc(postId);
    documents.delete();

    List<Post> newPosts = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id != postId) {
        newPosts.add(state.posts![i]);
      }
    }

    emit(state.copyWith(posts: newPosts));
  }

  void updatePost(Post deletePost, String title, String content) async {
    var documents = await _postingCollection.doc(deletePost.id);
    documents.update({"title": title, "content": content});

    List<Post> newPosts = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id != deletePost.id) {
        newPosts.add(state.posts![i]);
      } else {
        // 업데이트 하려는 문서라면
        newPosts.add(deletePost.copyWith(
          title: title,
          content: content,
        ));
      }
    }

    emit(state.copyWith(posts: newPosts));
  }

  void addPostComment(Post post, String content) async {
    var documents = await _postingCollection.doc(post.id);

    var createAt = DateFormat.yMd().add_jm().format(DateTime.now()).toString();
    var comment =
        Comment(content: content, createAt: createAt, author: "doitduri")
            .toJson();
    var firebaseComment = FieldValue.arrayUnion([comment]);

    documents.update({"comments": firebaseComment});

    List<Post> newPost = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id == post.id) {
        print("state.posts![i] ${state.posts![i]}");
        newPost.add(state.posts![i].copyWith(
            comments: state.posts![i].comments == null
                ? [comment]
                : state.posts![i].comments! + [comment]));
      } else {
        newPost.add(state.posts![i].copyWith());
      }
    }

    print("state.posts!=newPost ${state.posts!=newPost}");

    emit(state.copyWith(posts: newPost));
  }

  void deletePostComment(int index, Post post, int commentId) async {
    var documents = await _postingCollection.doc(post.id);

    List<dynamic> comments = [];

    for (int i = 0; i < state.posts![index].comments!.length; i++) {
      if (i != commentId) {
        comments.add(state.posts![index].comments![i]);
      }
    }

    print(comments);

    List<Post> newPost = [];

    for (int i = 0; i < state.posts!.length; i++) {
      if (state.posts![i].id == post.id) {
        newPost.add(state.posts![i].copyWith(comments: comments));
      } else {
        newPost.add(state.posts![i]);
      }
    }

    print(newPost[index].comments!.length);
    print(newPost[index].comments);

    emit(state.copyWith(posts: newPost));

    var firebaseComment = FieldValue.arrayUnion(comments);
    documents.set({
      "author": post.author,
      "comments": firebaseComment,
      "content": post.content,
      "title": post.title,
      "createAt": post.createAt
    });
  }
}
