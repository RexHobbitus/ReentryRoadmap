import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserEntity?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      return null;
    }
  }

  Future<UserEntity?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      return null;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      }
      throw Exception('Failed to send password reset email: ${e.message}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserEntity?> getCurrentUser() async {
    User? user = _auth.currentUser;
    return _userFromFirebase(user);
  }

  UserEntity? _userFromFirebase(User? user) {
    if (user != null) {
      return UserEntity(uid: user.uid, email: user.email ?? '');
    }
    return null;
  }
}
