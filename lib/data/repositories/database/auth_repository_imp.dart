import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/exceptions/firebase_exception_wrapper.dart';
import 'package:reentry_roadmap/data/models/app_user_json.dart';

import '../../../domain/entities/app_user.dart';
import '../../../domain/repositories/database/auth_repository.dart';
import 'firebase_collection.dart';

class AuthRepositoryImp extends FirebaseCollection implements AuthRepository {
  @override
  Future<AppUser> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      /// first authenticate user
      var userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      ///  get user record
      var userDocument =
          await usersCollection.doc(userCredential.user?.uid).get();

      /// get data of user  => convert to Model class (data layer) => then entity (domain layer) => return;
      return AppUserJson.fromJson(userDocument.data() as Map<String, dynamic>)
          .toDomain();
    } on FirebaseException catch (exception) {
      throw FirebaseExceptionWrapper(exception);
    }
  }

  @override
  Future<AppUser> createAccount(
      {required String email, required String password}) async {
    var userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await usersCollection.doc(userCredential.user?.uid).set({
      "email": email,
      "userId": userCredential.user?.uid,
      "createdAt": Timestamp.now(),
      "updatedAt": Timestamp.now(),
    });
    return (await getCurrentUser())!;
  }

  @override
  Future<bool> forgetPassword({required String email}) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      print("user id: ${auth.currentUser?.uid}");
      if (auth.currentUser?.uid == null) {
        return null;
      }

      ///  get user record
      var userDocument = await usersCollection.doc(auth.currentUser?.uid).get();
      /// get data of user  => convert to Model class (data layer) => then entity (domain layer) => return;
      return AppUserJson.fromJson(userDocument.data() as Map<String, dynamic>)
          .toDomain();
    } on FirebaseException catch (exception) {
      throw FirebaseExceptionWrapper(exception);
    }
  }
}
