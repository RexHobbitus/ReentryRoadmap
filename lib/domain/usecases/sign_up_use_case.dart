import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';

import '../stores/user_store.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  final UserStore userStore;

  SignUpUseCase({
    required this.authRepository,
    required this.userStore,
  });

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    AppUser user = await authRepository.createAccount(
      email: email,
      password: password,
    );
    userStore.setUser(user);
  }
}
