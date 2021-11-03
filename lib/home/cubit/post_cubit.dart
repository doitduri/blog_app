
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._postingCollection) : super(const PostState());

  final CollectionReference _postingCollection;

  void addPost(title, content) async {
    DocumentReference newDoc = await _postingCollection.add({"title": title, "content": content});

    Post newPost = Post.fromJson({"id": newDoc.id, "title": title});

    emit(state.copyWith(
      posts: state.posts==null? [newPost] : [newPost] + state.posts!
    ));
  }

  void getPosts() async {
    var documents = await _postingCollection.get();

    List<Post> newPosts = [];

    documents.docs.forEach((element) {
      newPosts.add(Post(id: element.id, title: element["title"]));
    });

    emit(state.copyWith(
      posts: newPosts
    ));
  }
}