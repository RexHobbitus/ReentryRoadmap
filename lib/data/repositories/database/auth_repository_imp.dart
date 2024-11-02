import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reentry_roadmap/data/exceptions/firebase_exception_wrapper.dart';
import 'package:reentry_roadmap/data/models/app_user_json.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';

import '../../../domain/entities/login_user.dart';
import '../../../domain/repositories/database/auth_repository.dart';
import 'firebase_collection.dart';

class AuthRepositoryImp extends FirebaseCollection implements AuthRepository {
  @override
  Future<LoginUser> loginWithEmailAndPassword({required String email, required String password, required role}) async {
    try {
      /// first authenticate user
      var userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      if (role == "user") {
        ///  get user record
        var userDocument = await usersCollection.doc(userCredential.user?.uid).get();

        return LoginUser(
            role: "user", data: AppUserJson.fromJson(userDocument.data() as Map<String, dynamic>).toDomain());
      } else {
        var userDocument = await providersCollection.doc(userCredential.user?.uid).get();

        return LoginUser(
            role: "provider", data: ProviderJson.fromJson(userDocument.data() as Map<String, dynamic>).toDomain());
      }
    } on FirebaseException catch (exception) {
      throw FirebaseExceptionWrapper(exception);
    }
  }

  @override
  Future<LoginUser> createAccount({required String email, required String password, required String role}) async {
    var userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    role == "user"
        ? await usersCollection.doc(userCredential.user?.uid).set({
            "email": email,
            "userId": userCredential.user?.uid,
            "createdAt": Timestamp.now(),
            "updatedAt": Timestamp.now(),
          })
        : await providersCollection.doc(userCredential.user?.uid).set({
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
  Future<LoginUser?> getCurrentUser() async {
    try {
      debugPrint("CURRENT USER ID: ${auth.currentUser?.uid}");
      if (auth.currentUser?.uid == null) {
        return null;
      }

      ///  get user record
      var userDocument = await usersCollection.doc(auth.currentUser?.uid).get();
      if (userDocument.exists) {
        return LoginUser(
            data: AppUserJson.fromJson(userDocument.data() as Map<String, dynamic>).toDomain(), role: "user");
      } else {
        var userDocument = await providersCollection.doc(auth.currentUser?.uid).get();
        if (!userDocument.exists) {
          await logout();
          return null;
        }
        return LoginUser(
            role: "provider", data: ProviderJson.fromJson(userDocument.data() as Map<String, dynamic>).toDomain());
      }
    } on FirebaseException catch (exception) {
      throw FirebaseExceptionWrapper(exception);
    }
  }

  @override
  Future<LoginUser?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        throw FirebaseExceptionWrapper(
          FirebaseException(
            plugin: 'firebase_auth',
            code: 'user-not-found',
            message: 'No user currently logged in',
          ),
        );
      }

      final email = user.email;
      if (email == null || email.isEmpty) {
        throw FirebaseExceptionWrapper(
          FirebaseException(
            plugin: 'firebase_auth',
            code: 'invalid-email',
            message: 'User email is invalid or missing.',
          ),
        );
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return await getCurrentUser();
    } on FirebaseAuthException catch (exception) {
      throw FirebaseExceptionWrapper(exception);
    }
  }
}
