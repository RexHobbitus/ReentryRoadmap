import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import '../entities/onboarding_info.dart';
import 'dart:developer' as logger;

class OnboardingUseCase {
  final AppUserRepository appUserRepository;
  final AuthRepository authRepository;
  final UserStore userStore;

  OnboardingUseCase({
    required this.authRepository,
    required this.appUserRepository,
    required this.userStore,
  });

  Future<void> execute(OnboardingInfo onboardingInfo) async {
    logger.log("${onboardingInfo.toJson()}");
    await appUserRepository.submitAssessment(onboardingInfo);
    LoginUser? loginUser = await authRepository.getCurrentUser();
    userStore.setUser(loginUser!);
  }
}
