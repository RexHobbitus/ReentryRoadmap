import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
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
    LoginUser? loginUser=await authRepository.getCurrentUser();
    if(loginUser!=null){
       userStore.setUser(loginUser);
      if(loginUser.role=="user"){
        AppUser user=loginUser.data as AppUser;
        return user.onboardingInfo==null?
        UserSessionStatus.userLoggedInWithNoOnboarding:UserSessionStatus.loggedIn;
      }else{
        Provider provider=loginUser.data as Provider;
        return provider.onboardingInfo==null?
        UserSessionStatus.providerLoggedInWithNoOnboarding:UserSessionStatus.loggedIn;
      }
    }
    return UserSessionStatus.notLoggedIn;
  }
}
