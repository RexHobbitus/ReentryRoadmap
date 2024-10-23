import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';

import '../../entities/onboarding_info.dart';

abstract class ProviderOnboardingRepository {
  Future<void> submitAssessment(ProviderOnboardingInfo providerOnboardingInfo);
}
