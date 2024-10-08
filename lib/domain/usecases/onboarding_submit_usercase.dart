
import 'package:reentry_roadmap/domain/entities/onboarding_info.dart';
import 'package:reentry_roadmap/domain/repositories/database/onboarding_repository.dart';

class SubmitOnboardingUseCase {
  final OnboardingRepository repository;

  SubmitOnboardingUseCase(this.repository);

  Future<void> call(OnboardingInfo onboardingInfo) {
    return repository.submitAssessment(onboardingInfo);
  }
}
