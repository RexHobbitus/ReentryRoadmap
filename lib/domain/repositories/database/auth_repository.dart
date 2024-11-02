import '../../entities/login_user.dart';

abstract class AuthRepository {
  Future<LoginUser?> getCurrentUser();

  Future<LoginUser> loginWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
  });

  Future<LoginUser> createAccount({required String email, required String password, required String role});

  Future<bool> forgetPassword({required String email});

  Future<LoginUser?> changePassword({required String currentPassword, required String newPassword});

  Future<void> logout();
}
