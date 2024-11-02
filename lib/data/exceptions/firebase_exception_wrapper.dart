import 'package:firebase_core/firebase_core.dart';

class FirebaseExceptionWrapper {
  final FirebaseException _exception;

  FirebaseExceptionWrapper(this._exception);
  String get message {
    print(_exception.code);
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
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again and try again.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'invalid-credential':
        return 'The credential provided is invalid or has expired.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'unverified-email':
        return 'The email address is not verified. Please verify it and try again.';

      default:
        return 'An error occurred: ${_exception.message}';
    }
  }

  @override
  String toString() {
    return message;
  }
}
