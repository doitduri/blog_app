
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  final postRepository = FirebaseFirestore.instance.collection('post');

  // Future<void> addNewPost(Post post) {
  //   // return postRepository.doc(post.id).set(Post.fromJson(data).toJson());
  // }
}