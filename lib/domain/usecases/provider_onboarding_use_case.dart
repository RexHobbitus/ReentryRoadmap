import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_onboarding_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import '../repositories/database/onboarding_repository.dart';
import '../entities/onboarding_info.dart';
import 'dart:developer' as logger;

class ProviderOnboardingUseCase {
  final ProviderOnboardingRepository providerOnboardingRepository;
  final AuthRepository authRepository;
  final UserStore userStore;

  ProviderOnboardingUseCase({
    required this.authRepository,
    required this.providerOnboardingRepository,
    required this.userStore,
  });

  Future<void> execute(ProviderOnboardingInfo providerOnboardingInfo) async {
    // logger.log("${providerOnboardingInfo.toJson()}");

    await providerOnboardingRepository.submitAssessment(providerOnboardingInfo);
    LoginUser? user = await authRepository.getCurrentUser();
    userStore.setUser(user!);
  }
}
