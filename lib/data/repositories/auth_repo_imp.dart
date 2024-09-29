import 'dart:math';

import 'package:reentry_roadmap/data/repositories/auth_repo.dart';
import 'package:reentry_roadmap/domain/repositories/user_repository.dart';
import 'package:reentry_roadmap/presentation/pages/login_signup.dart';

import '../../domain/entities/user_entity.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  AuthRepositoryImpl(this._firebaseAuthDataSource);

  @override
  Future<UserEntity?> login(String email, String password) {
    return _firebaseAuthDataSource.login(email, password);
  }

  @override
  Future<UserEntity?> register(String email, String password) {
    return _firebaseAuthDataSource.register(email, password);
  }

  @override
  Future<void> logout() {
    return _firebaseAuthDataSource.logout();
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    return await _firebaseAuthDataSource.forgotPassword(email);
  }

  @override
  Future<UserEntity?> getCurrentUser() {
    return _firebaseAuthDataSource.getCurrentUser();
  }
}
