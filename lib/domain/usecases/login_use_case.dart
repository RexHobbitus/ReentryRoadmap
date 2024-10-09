import 'package:reentry_roadmap/core/enums/user_session_status.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';

import '../stores/user_store.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  final UserStore userStore;

  LoginUseCase({
    required this.authRepository,
    required this.userStore,
  });

  Future<UserSessionStatus> execute({
    required String email,
    required String password,
  }) async {
    AppUser user = await authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    userStore.setUser(user);
    if(user.onboardingInfo==null){
      return UserSessionStatus.loggedInWithNoOnboarding;
    }
    return UserSessionStatus.loggedIn;
  }
}
