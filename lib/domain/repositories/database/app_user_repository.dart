
import 'package:reentry_roadmap/domain/entities/provider_review.dart';

import '../../entities/onboarding_info.dart';

abstract class AppUserRepository {
  Future<void> submitAssessment(OnboardingInfo onboardingInfo);
  Future<void> giveReviewToProvider({required String providerId,required ProviderReview review});

}