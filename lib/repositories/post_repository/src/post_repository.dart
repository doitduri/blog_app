import 'package:blog_app/repositories/post_repository/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  PostRepository();

  final postingCollection = FirebaseFirestore.instance.collection('posting');

  // Post: 글
  Future<DocumentReference> addNewPost(title, content, plainContent) async {
    DocumentReference newDoc = await postingCollection.add({
      "title": title,
      "content": content,
      "plainContent": plainContent,
      "createAt": DateTime.now(),
      // TODO 파이어베이스로 연동해놓았긴 했지만, 편의상 직접 계정이름을 넣어 작업함
      //  (로그인 연동 필요 시 해당 코드 수정 필요)
      "author": "doitduri",
      "comments": []
    });
    return newDoc;
  }

  Future<QuerySnapshot> getAllPosts(bool descending) async {
    var documents = await postingCollection
        .orderBy("createAt", descending: descending)
        .get();

    return documents;
  }

  Future<void> deletePost(String postId) async {
    var documents = postingCollection.doc(postId);
    documents.delete();
  }

  Future<void> updatePost(String postId, String title, String content,
      String updatePlainContent) async {
    var documents = postingCollection.doc(postId);
    documents.update({
      "title": title,
      "content": content,
      "plainContent": updatePlainContent
    });
  }

  // Comment : 덧글
  Future<void> addPostComment(Post commentPost, Map newComment) async {
    var documents = postingCollection.doc(commentPost.id);
    var firebaseComment = FieldValue.arrayUnion([newComment]);

    documents.update({"comments": firebaseComment});
  }

  Future<void> deletePostComment(Post commentPost, List newComments) async {
    var documents = postingCollection.doc(commentPost.id);

    var firebaseComment = FieldValue.arrayUnion(newComments);
    documents.set({
      "author": commentPost.author,
      "comments": firebaseComment,
      "content": commentPost.content,
      "title": commentPost.title,
      "createAt": commentPost.createAt
    });
  }
}
