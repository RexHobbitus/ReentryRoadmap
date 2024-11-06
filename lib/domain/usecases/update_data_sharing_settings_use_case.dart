import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import '../entities/data_sharing_settings.dart';

class UpdateDataSharingSettingsUseCase {
  final AppUserRepository appUserRepository;
  final AuthRepository authRepository;
  final UserStore userStore;
  UpdateDataSharingSettingsUseCase({
    required this.appUserRepository,
    required this.authRepository,
    required this.userStore,
  });

  Future<void> execute(UserDataSharingSettings settings) async {
    await appUserRepository.updateUserDataSharingSettings(settings);
    LoginUser? user = await authRepository.getCurrentUser();
    userStore.setUser(user!);
  }
}
