import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/user_profile_update.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

class UpdateUserProfileInfoUseCase {
  final AppUserRepository appUserRepository;
  final AuthRepository authRepository;
  final UserStore userStore;
  UpdateUserProfileInfoUseCase({
    required this.appUserRepository,
    required this.authRepository,
    required this.userStore,
  });

  Future<void> execute(UserProfileUpdateInfo updatedData) async {
    await appUserRepository.updateUserProfileInfo(updatedData);
    LoginUser? user = await authRepository.getCurrentUser();
    userStore.setUser(user!);
  }
}
