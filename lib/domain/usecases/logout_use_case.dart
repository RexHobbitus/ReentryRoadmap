import 'package:reentry_roadmap/core/enums/user_session_status.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';

import '../stores/user_store.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  final UserStore userStore;

  LogoutUseCase({
    required this.authRepository,
    required this.userStore,
  });

  Future<void> execute() async {
    await authRepository.logout();
    userStore.setUser(AppUser.empty());
  }
}
