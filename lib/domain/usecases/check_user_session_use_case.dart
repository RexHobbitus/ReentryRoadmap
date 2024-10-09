import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import '../../core/enums/user_session_status.dart';

class CheckUserSessionUseCase {
  final AuthRepository authRepository;
  final UserStore userStore;

  CheckUserSessionUseCase({
    required this.authRepository,
    required this.userStore,
  });


  Future<UserSessionStatus> execute() async{
    AppUser? appUser=await authRepository.getCurrentUser();
    if(appUser!=null){
      userStore.setUser(appUser);
      if(appUser.onboardingInfo==null){
        return UserSessionStatus.loggedInWithNoOnboarding;
      }
      return UserSessionStatus.loggedIn;
    }
    return UserSessionStatus.notLoggedIn;
  }
}
