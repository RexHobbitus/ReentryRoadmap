import 'package:flutter/material.dart';
import 'package:reentry_roadmap/data/usecases/onboarding_submit_usercase.dart';

class AssessmentProvider extends ChangeNotifier {
  final SubmitOnboardingUseCase submitAssessmentUseCase;

  // Store the user's answers per section
  final Map<String, Map<String, dynamic>> _answers = {};

  AssessmentProvider(this.submitAssessmentUseCase);

  void saveSectionAnswers(String section, Map<String, dynamic> sectionAnswers) {
    _answers[section] = sectionAnswers;
    notifyListeners();
  }

  Future<void> submitAllAnswers() async {
    await submitAssessmentUseCase.call(_answers);
  }

  Map<String, Map<String, dynamic>> get allAnswers => _answers;
}
