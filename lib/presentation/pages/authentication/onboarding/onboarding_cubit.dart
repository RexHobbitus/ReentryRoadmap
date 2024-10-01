import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_dob_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_intro.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_location_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_name_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_phone_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_veteran_section.dart';
import 'onboarding_initial_params.dart';
import 'onboarding_state.dart';
import 'onboarding_navigator.dart';
import 'steps/personal_details/personal_details_ethnicity_section.dart';
import 'steps/personal_details/personal_details_gender_section.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingNavigator navigator;

  OnboardingCubit({required this.navigator}) : super(OnboardingState.initial());

  BuildContext get context => navigator.context;

  onInit(OnboardingInitialParams initialParams) {}

  /// Personal details section
  ///
  ///
  final txtFullName = TextEditingController();
  final txtDob = TextEditingController();
  String selectedEthnicity = "";
  String selectedGender = "";
  String selectedVeteran = "";
  final txtLocationStreet = TextEditingController();
  final txtLocationCity = TextEditingController();
  TextEditingController txtLocationState = TextEditingController();
  final txtPhoneNumber = TextEditingController();

  List<Widget> get onBoardingSteps => [
        PersonalDetailsIntro(),
        PersonalDetailsNameSection(),
        PersonalDetailsDobSection(),
        PersonalDetailsEthnicitySection(),
        PersonalDetailsGenderSection(),
        PersonalDetailsVeteranSection(),
        PersonalDetailsLocationSection(),
        PersonalDetailsPhoneSection(),
      ];

  disposeControllers() {
    txtFullName.clear();
    debugPrint("controller disposed.....");
  }

  nextStepAction() {
    if (state.onboardingSectionIndex == onBoardingSteps.length - 1) {
      return;
    }
    int step = state.onboardingSectionIndex + 1;
    emit(state.copyWith(onboardingSectionIndex: step));
  }

  backAction() {
    if (state.onboardingSectionIndex == 0) {
      Navigator.pop(context);
      return;
    }
    int step = state.onboardingSectionIndex - 1;
    emit(state.copyWith(onboardingSectionIndex: step));
  }
}
