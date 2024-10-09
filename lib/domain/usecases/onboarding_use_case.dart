import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import '../repositories/database/onboarding_repository.dart';
import '../entities/onboarding_info.dart';
import 'dart:developer' as logger;

class OnboardingUseCase {
  final OnboardingRepository onboardingRepository;
  final AuthRepository authRepository;
  final UserStore userStore;

  OnboardingUseCase({
    required this.authRepository,
    required this.onboardingRepository,
    required this.userStore,
  });

  Future<void> execute(OnboardingInfo onboardingInfo) async {
    logger.log("${onboardingInfo.toJson()}");
    await onboardingRepository.submitAssessment(onboardingInfo);
    AppUser? user = await authRepository.getCurrentUser();
    userStore.setUser(user!);
  }
}
