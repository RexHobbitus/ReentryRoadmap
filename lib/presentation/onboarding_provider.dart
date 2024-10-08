import 'package:flutter/material.dart';
import 'package:reentry_roadmap/domain/usecases/onboarding_submit_usercase.dart';
import 'package:reentry_roadmap/domain/entities/app_provider.dart';
import 'package:reentry_roadmap/domain/entities/current_needs_info.dart';
import 'package:reentry_roadmap/domain/entities/incarceration_info.dart';
import 'package:reentry_roadmap/domain/entities/onboarding_info.dart';
import 'package:reentry_roadmap/domain/entities/personal_info.dart';

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
    final _onboardingInfo=OnboardingInfo(
      personalInfo: PersonalInfo(fullName: "Abdullah",dateOfBirth: "2019-07-07T18:30:00.000Z"),
      incarcerationInfo: IncarcerationInfo(idNumber: "abcm123",numberOfTimesIncarcerated: "10"),
      currentNeedsInfo: CurrentNeedsInfo(providers:[
        AppProvider(providerName: "Test",providerLogo: "httos",accessedDate: "2019-07-07T18:30:00.000Z"),
        AppProvider(providerName: "Test",providerLogo: "httos",accessedDate: "2019-07-07T18:30:00.000Z")
      ]),

    );
    await submitAssessmentUseCase.call(_onboardingInfo);
  }

  Map<String, Map<String, dynamic>> get allAnswers => _answers;
}
