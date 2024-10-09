
import 'package:firebase_core/firebase_core.dart';

class FirebaseExceptionWrapper {
  final FirebaseException _exception;

  FirebaseExceptionWrapper(this._exception);
  String get message {
    switch (_exception.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Invalid password.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'email-already-in-use':
        return 'Email is already in use.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      default:
        return 'An error occurred: ${_exception.message}';
    }
  }

  @override
  String toString() {
    return message;
  }
}