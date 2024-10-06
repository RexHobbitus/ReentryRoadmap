
import 'package:reentry_roadmap/domain/repositories/database/onboarding_repository.dart';

class SubmitOnboardingUseCase {
  final OnboardingRepository repository;

  SubmitOnboardingUseCase(this.repository);

  Future<void> call(Map<String, Map<String, dynamic>> answers) {
    return repository.submitAssessment(answers);
  }
}
