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
import 'steps/incarceration_details/incarceration_details_first_incarcerated_date.dart';
import 'steps/incarceration_details/incarceration_details_id_number.dart';
import 'steps/incarceration_details/incarceration_details_incarcerated_time.dart';
import 'steps/incarceration_details/incarceration_details_incarceration_history.dart';
import 'steps/incarceration_details/incarceration_details_incarceration_length.dart';
import 'steps/incarceration_details/incarceration_details_intro.dart';
import 'steps/incarceration_details/incarceration_details_latest_release_date.dart';
import 'steps/incarceration_details/incarceration_details_offences_section.dart';
import 'steps/incarceration_details/incarceration_details_programs_section.dart';
import 'steps/incarceration_details/incarceration_details_recent_serve.dart';
import 'steps/personal_details/personal_details_ethnicity_section.dart';
import 'steps/personal_details/personal_details_gender_section.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingNavigator navigator;

  OnboardingCubit({required this.navigator}) : super(OnboardingState.initial());

  BuildContext get context => navigator.context;

  onInit(OnboardingInitialParams initialParams) {}

  /// Personal Details section
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

  /// Incarceration Details Section
  ///
  ///

  final txtIdType = TextEditingController();
  final txtIdNumber = TextEditingController();
  final txtOtherIdType = TextEditingController();
  String selectedIncarceratedBefore = "";
  String selectedIncarceratedHistory = "";
  List<String> selectedTypeOfOffences = [];
  String selectedLongestIncarcerationLength = "";
  String selectedLatestIncarcerationLength = "";
  final txtFirstIncarceratedDate = TextEditingController();
  final txtLatestReleaseDate = TextEditingController();
  String selectedServeMost ="";
  List<String> selectedPrograms = [];



  List<Widget> get onBoardingSteps => [
        /// 1st part
        PersonalDetailsIntro(),
        PersonalDetailsNameSection(),
        PersonalDetailsDobSection(),
        PersonalDetailsEthnicitySection(),
        PersonalDetailsGenderSection(),
        PersonalDetailsVeteranSection(),
        PersonalDetailsLocationSection(),
        PersonalDetailsPhoneSection(),

        /// 2nd part
        IncarcerationDetailsIntro(),
        IncarcerationDetailsIdNumber(),
        IncarcerationDetailsIncarceratedTime(),
        IncarcerationDetailsIncarcerationHistory(),
        IncarcerationDetailsOffencesSection(),
        IncarcerationDetailsIncarcerationLength(),
        IncarcerationDetailsFirstIncarceratedDate(),
        IncarcerationDetailsLatestReleaseDate(),
        IncarcerationDetailsRecentServe(),
        IncarcerationDetailsProgramsSection(),
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
