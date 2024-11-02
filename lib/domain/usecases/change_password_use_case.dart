import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';

import '../stores/user_store.dart';

class ChangePasswordUseCase {
  final AuthRepository authRepository;
  final UserStore userStore;

  ChangePasswordUseCase({
    required this.authRepository,
    required this.userStore,
  });

  Future<void> execute({
    required String currentPassword,
    required String newPassword,
  }) async {
    final loginUser = await authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    if (loginUser != null) userStore.setUser(loginUser);
  }
}
