import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._postingCollection) : super(const PostState());

  final CollectionReference _postingCollection;

  void addPost(title, content) async {
    var createAt =  DateFormat.yMMMMd('en_US').format(DateTime.now()).toString();

    // TODO 파이어베이스로 연동해놓았긴 했지만, 편의상 직접 계정이름을 넣어 작업함 (로그인 연동 필요 시 해당 코드 수정 필요)
    DocumentReference newDoc = await _postingCollection.add({
      "title": title,
      "content": content,
      "createAt": createAt,
      "author": "doitduri"
    });

    Post newPost = Post.fromJson({
      "id": newDoc.id,
      "title": title,
      "createAt": createAt,
      "author": "doitduri"
    });

    emit(state.copyWith(
        posts: state.posts == null ? [newPost] : [newPost] + state.posts!));
  }

  void getPosts() async {
    var documents = await _postingCollection.get();

    List<Post> newPosts = [];

    documents.docs.forEach((element) {
      newPosts.add(Post(
          id: element.id,
          title: element["title"],
          createAt: element["createAt"],
          author: element["author"]));
    });

    emit(state.copyWith(posts: newPosts));
  }
}
