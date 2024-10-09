
import '../../entities/onboarding_info.dart';

abstract class OnboardingRepository {
  Future<void> submitAssessment(OnboardingInfo onboardingInfo);
}
