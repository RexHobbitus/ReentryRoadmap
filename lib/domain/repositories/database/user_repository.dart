import 'package:reentry_roadmap/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> register(String email, String password);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<UserEntity?> getCurrentUser();
}