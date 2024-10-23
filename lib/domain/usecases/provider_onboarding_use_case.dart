import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import 'dart:developer' as logger;

class ProviderOnboardingUseCase {
  final ProviderRepository providerRepository;
  final AuthRepository authRepository;
  final UserStore userStore;

  ProviderOnboardingUseCase({
    required this.authRepository,
    required this.providerRepository,
    required this.userStore,
  });

  Future<void> execute(ProviderOnboardingInfo providerOnboardingInfo,
      List<dynamic> images) async {
    // logger.log("${providerOnboardingInfo.toJson()}");
    providerOnboardingInfo.providerDetails!.images =
        await providerRepository.uploadFiles(images);
    await providerRepository.submitAssessment(providerOnboardingInfo);
    LoginUser? user = await authRepository.getCurrentUser();
    userStore.setUser(user!);
  }
}
