import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';

import '../stores/user_store.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  final UserStore userStore;

  SignUpUseCase({
    required this.authRepository,
    required this.userStore,
  });

  Future<LoginUser> execute({
    required String email,
    required String password,
    required String role,

  }) async {
    LoginUser loginUser = await authRepository.createAccount(
      email: email,
      password: password,
      role:role,
    );
    userStore.setUser(loginUser);
    return loginUser;
  }
}
