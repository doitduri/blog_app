import 'package:firebase_auth/firebase_auth.dart';

import 'user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> authenticate() {
    return _firebaseAuth.signInWithEmailAndPassword(email: "doitduri@gmail.com", password: "duriTest!123");
  }

  String? getUserId() => _firebaseAuth.currentUser?.uid;
}
