import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/entities/current_needs_info.dart';
import 'package:reentry_roadmap/domain/entities/incarceration_info.dart';
import 'package:reentry_roadmap/domain/entities/onboarding_info.dart';
import 'package:reentry_roadmap/domain/entities/personal_info.dart';
import 'package:reentry_roadmap/domain/entities/service_provider_accessed.dart';
import 'package:reentry_roadmap/domain/usecases/onboarding_use_case.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_dob_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_intro.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_location_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_name_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_phone_section.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/steps/personal_details/personal_details_veteran_section.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import '../../../../domain/entities/career.dart';
import '../../../../domain/entities/service_provider.dart';
import 'onboarding_initial_params.dart';
import 'onboarding_state.dart';
import 'onboarding_navigator.dart';
import 'steps/current_needs/current_needs_career_change.dart';
import 'steps/current_needs/current_needs_current_career.dart';
import 'steps/current_needs/current_needs_education_level.dart';
import 'steps/current_needs/current_needs_employment_status.dart';
import 'steps/current_needs/current_needs_expected_salary.dart';
import 'steps/current_needs/current_needs_future_career.dart';
import 'steps/current_needs/current_needs_housing_status.dart';
import 'steps/current_needs/current_needs_intro.dart';
import 'steps/current_needs/current_needs_other_resource.dart';
import 'steps/current_needs/current_needs_salary_level.dart';
import 'steps/current_needs/current_needs_service_provider_type.dart';
import 'steps/current_needs/current_needs_skills_to_improve.dart';
import 'steps/current_needs/current_needs_top_priorities.dart';
import 'steps/current_needs/current_needs_trade_certifications.dart';
import 'steps/incarceration_details/incarceration_details_first_incarcerated_date.dart';
import 'steps/incarceration_details/incarceration_details_id_number.dart';
import 'steps/incarceration_details/incarceration_details_incarcerated_time.dart';
import 'steps/incarceration_details/incarceration_details_incarceration_history.dart';
import 'steps/incarceration_details/incarceration_details_incarceration_length.dart';
import 'steps/incarceration_details/incarceration_details_intro.dart';
import 'steps/incarceration_details/incarceration_details_latest_incarceration.dart';
import 'steps/incarceration_details/incarceration_details_latest_release_date.dart';
import 'steps/incarceration_details/incarceration_details_offences_section.dart';
import 'steps/incarceration_details/incarceration_details_programs_section.dart';
import 'steps/incarceration_details/incarceration_details_recent_serve.dart';
import 'steps/personal_details/personal_details_ethnicity_section.dart';
import 'steps/personal_details/personal_details_gender_section.dart';
import 'steps/service_providers/service_providers_access_dates.dart';
import 'steps/service_providers/service_providers_accessed_so_far.dart';
import 'steps/service_providers/service_providers_intro.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingNavigator navigator;
  OnboardingUseCase onboardingUseCase;
  AppSnackBar snackBar;

  OnboardingCubit({
    required this.navigator,
    required this.onboardingUseCase,
    required this.snackBar,
  }) : super(OnboardingState.initial());

  BuildContext get context => navigator.context;

  onInit(OnboardingInitialParams initialParams) {}

  /// Personal Details section
  ///
  ///

  String firstName = "";
  String middleName = "";
  String lastName = "";

  DateTime? selectedDob;

  String selectedEthnicity = "";
  String selectedGender = "";
  String selectedVeteran = "";

  String locationStreet = "";
  String locationCity = "";
  String locationState = "";

  String phoneNumber = "";

  /// Incarceration Details Section
  ///
  ///

  String idType = "";
  String idNumber = "";
  String otherIdType = "";
  String selectedIncarceratedBefore = "";
  String selectedIncarceratedHistory = "";
  List<String> selectedTypeOfOffences = [];
  String selectedLongestIncarcerationLength = "";
  String selectedLatestIncarcerationLength = "";
  DateTime? firstIncarceratedDate;
  DateTime? latestReleaseDate;
  String selectedServeMost = "";
  List<String> selectedPrograms = [];

  /// current needs Section
  ///
  ///
  List<String> selectedTopPriorities = [];
  String selectedServiceProviderSize = "";
  String selectedHousingStatus = "";
  String needOfImmediateHousing = "";
  String highestLevelOfEducation = "";
  List<String> tradeCertifications = [];
  List<SkillToImprove> skillsToImprove = [];
  bool isNoSkillToImprove = false;
  String selectedEmploymentStatus = "";
  Career? currentCareer;

  String currentSalaryLevel = "";
  String lookingForCareerChange = "";
  List<Career> careersToPursue = [];
  String expectedSalaryLevel = "";
  String otherResource = "";
  bool isOtherResource = true;

  /// service Providers info
  List<ServiceProvider> selectedProviders = [];
  bool noServiceProviderAccessedSoFar = false;

  final textFieldUpdateListener = StreamController<bool>.broadcast();

  notifyTextFieldUpdates() {
    textFieldUpdateListener.add(true);
  }

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
        IncarcerationDetailsLatestIncarceration(),
        IncarcerationDetailsFirstIncarceratedDate(),
        IncarcerationDetailsLatestReleaseDate(),
        IncarcerationDetailsRecentServe(),
        IncarcerationDetailsProgramsSection(),

        /// 3rd part
        CurrentNeedsIntro(),
        CurrentNeedsTopPriorities(),
        CurrentNeedsServiceProviderType(),
        CurrentNeedsHousingStatus(),
        CurrentNeedsEducationLevel(),
        CurrentNeedsTradeCertifications(),
        CurrentNeedsSkillsToImprove(),
        CurrentNeedsEmploymentStatus(),
        CurrentNeedsCurrentCareer(),
        CurrentNeedsSalaryLevel(),
        CurrentNeedsCareerChange(),
        CurrentNeedsFutureCareer(),
        CurrentNeedsExpectedSalary(),
        CurrentNeedsOtherResource(),

        /// 4th part
        ServiceProvidersIntro(),
        ServiceProvidersAccessedSoFar(),
        ServiceProvidersAccessDates(),
      ];

  disposeControllers() {
    debugPrint("controller disposed.....");
  }

  bool isNextButtonEnabled() {
    switch (state.onboardingSectionIndex) {
      case 0:

        /// Personal Info
        return true;
      case 1:
        return firstName.isNotEmpty && lastName.isNotEmpty;
      case 2:
        return selectedDob != null;
      case 3:
        return selectedEthnicity.isNotEmpty;
      case 4:
        return selectedGender.isNotEmpty;
      case 5:
        return selectedVeteran.isNotEmpty;
      case 6:
        return locationCity.isNotEmpty && locationState.isNotEmpty;
      case 7:
        return phoneNumber.isNotEmpty;

      case 8:

        /// Incarceration info

        return true;
      case 9:
        if (idType.toLowerCase().contains("other")) {
          return idType.isNotEmpty &&
              idNumber.isNotEmpty &&
              otherIdType.isNotEmpty;
        } else {
          return idType.isNotEmpty && idNumber.isNotEmpty;
        }
      case 10:
        return selectedIncarceratedBefore.isNotEmpty;
      case 11:
        return selectedIncarceratedHistory.isNotEmpty;
      case 12:
        return selectedTypeOfOffences.isNotEmpty;
      case 13:
        return selectedLongestIncarcerationLength.isNotEmpty;
      case 14:
        return selectedLatestIncarcerationLength.isNotEmpty;
      case 15:
        return firstIncarceratedDate != null;
      case 16:
        return latestReleaseDate != null;
      case 17:
        return selectedServeMost.isNotEmpty;
      case 18:
        return selectedPrograms.isNotEmpty;
      case 19:

        /// current needs
        return true;
      case 20:
        return selectedTopPriorities.isNotEmpty;
      case 21:
        return selectedServiceProviderSize.isNotEmpty;
      case 22:
        if (selectedHousingStatus.toLowerCase().contains("transitional")) {
          return needOfImmediateHousing.isNotEmpty;
        } else {
          return selectedHousingStatus.isNotEmpty;
        }
      case 23:
        return highestLevelOfEducation.isNotEmpty;
      case 24:
        return tradeCertifications.isNotEmpty;
      case 25:
        if (skillsToImprove.isNotEmpty) {
          if (skillsToImprove.first.title!.contains("Other")) {
            return skillsToImprove.first.subTitle!.isNotEmpty ||
                isNoSkillToImprove;
          }

          return true;
        }
        return false;
      case 26:
        return selectedEmploymentStatus.isNotEmpty;
      case 27:
        return currentCareer != null;
      case 28:
        return currentSalaryLevel.isNotEmpty;
      case 29:
        return lookingForCareerChange.isNotEmpty;
      case 30:
        return careersToPursue.isNotEmpty;
      case 31:
        return expectedSalaryLevel.isNotEmpty;
      case 32:
        return !isOtherResource || otherResource.isNotEmpty;
      case 33:
        /// service provider info
        return true;
      case 34:
        /// service provider info
        return selectedProviders.isNotEmpty || noServiceProviderAccessedSoFar;
      case 35:
        return selectedProviders.every((provider)=>provider.accessedDate!=null);
      default:
        return false;
    }
  }

  nextStepAction() {
    if (isOnboardingCompleted()) {
      _sendOnboardingInformation();
      return;
    }
    if (state.onboardingSectionIndex == onBoardingSteps.length - 1) {
      return;
    }
    int step = state.onboardingSectionIndex + 1;
    emit(state.copyWith(onboardingSectionIndex: step));
  }

  backAction() {
    if (state.onboardingSectionIndex == 0) {
      navigator.openExplore(const ExploreInitialParams());
      return;
    }
    int step = state.onboardingSectionIndex - 1;
    emit(state.copyWith(onboardingSectionIndex: step));
  }

  bool isOnboardingCompleted() {
    if (state.onboardingSectionIndex == onBoardingSteps.length - 1) {
      return true;
    }
    if (state.onboardingSectionIndex == onBoardingSteps.length - 2 &&
        noServiceProviderAccessedSoFar) {
      return true;
    }

    return false;
  }

  _sendOnboardingInformation() async {
    try {
      emit(state.copyWith(loading: true));
      PersonalInfo personalInfo = _getPersonalInformation();
      IncarcerationInfo incarcerationInfo = _getIncarcerationInfo();
      CurrentNeedsInfo currentNeedInfo = _getCurrentNeedInfo();
      ServiceProviderAccessed serviceProviderAccessed =
          _getServiceProviderAccessed();

      OnboardingInfo onboardingInfo = OnboardingInfo(
        personalInfo: personalInfo,
        incarcerationInfo: incarcerationInfo,
        currentNeedsInfo: currentNeedInfo,
        serviceProviderAccessed: serviceProviderAccessed,
      );

      await onboardingUseCase.execute(onboardingInfo);
      snackBar.show("Onboarding submitted successfully", snackBarType: SnackBarType.SUCCESS);
      navigator.openExplore(const ExploreInitialParams());
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  PersonalInfo _getPersonalInformation() {
    return PersonalInfo(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      dateOfBirth: selectedDob,
      ethnicity: selectedEthnicity,
      gender: selectedGender,
      veteranStatus: selectedVeteran,
      street: locationStreet,
      city: locationCity,
      state: locationState,
      phoneNumber: phoneNumber,
    );
  }

  IncarcerationInfo _getIncarcerationInfo() {
    return IncarcerationInfo(
        idType: idType,
        idNumber: idNumber,
        numberOfTimesIncarcerated: selectedIncarceratedBefore,
        incarceratedHistory: selectedIncarceratedHistory,
        latestOffenceType: selectedTypeOfOffences,
        lengthOfLongestIncarceration: selectedLongestIncarcerationLength,
        lengthOfLatestIncarceration: selectedLatestIncarcerationLength,
        firstIncarcerationDate: firstIncarceratedDate,
        latestReleaseDate: latestReleaseDate,
        mostRecentTermServerIn: selectedServeMost,
        programAttendedWhileIncarcerated: selectedPrograms);
  }

  CurrentNeedsInfo _getCurrentNeedInfo() {
    return CurrentNeedsInfo(
      currentTopPriorities: selectedTopPriorities,
      preferredServiceProviderSize: selectedServiceProviderSize,
      currentHousingStatus: selectedHousingStatus,
      needOfImmediateHousing: needOfImmediateHousing,
      highestLevelOfEducation: highestLevelOfEducation,
      tradeCertifications: tradeCertifications,
      skillsToImproveOn:
          skillsToImprove.map((skill) => skill.title.toString()).toList(),
      currentEmploymentStatus: selectedEmploymentStatus,
      currentCareerStatus: currentCareer?.title.toString(),
      currentSalaryStatus: currentSalaryLevel,
      lookingForCareerChange: lookingForCareerChange,
      aspiringCareerTrack:
          careersToPursue.map((career) => career.title.toString()).toList(),
      aspiringSalaryLevel: expectedSalaryLevel,
      otherResourceWanted: otherResource,
    );
  }

  ServiceProviderAccessed _getServiceProviderAccessed() {
    return ServiceProviderAccessed(serviceProviders: selectedProviders);
  }
}
