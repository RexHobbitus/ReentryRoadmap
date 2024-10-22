import 'package:reentry_roadmap/core/enums/user_session_status.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
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
    required String role,
  }) async {
    LoginUser loginUser = await authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
      role: role,
    );
    userStore.setUser(loginUser);
    if (loginUser.role=="user") {
      AppUser user=loginUser.data as AppUser;
      return user.onboardingInfo==null?
      UserSessionStatus.userLoggedInWithNoOnboarding:UserSessionStatus.loggedIn;
    }else{
      Provider provider=loginUser.data as Provider;
      return provider.onboardingInfo==null?
      UserSessionStatus.providerLoggedInWithNoOnboarding:UserSessionStatus.loggedIn;
    }
  }
}
