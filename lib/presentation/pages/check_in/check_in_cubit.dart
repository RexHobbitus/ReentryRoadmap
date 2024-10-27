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
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/steps/check_ins/check_in_service_providers_accessed.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import '../../../../domain/entities/career.dart';
import '../../../../domain/entities/service_provider.dart';
import 'steps/check_ins/check_in_career_change.dart';
import 'steps/check_ins/check_in_current_career.dart';
import 'steps/check_ins/check_in_education_level.dart';
import 'steps/check_ins/check_in_employment_status.dart';
import 'steps/check_ins/check_in_expected_salary.dart';
import 'steps/check_ins/check_in_future_career.dart';
import 'steps/check_ins/check_in_housing_status.dart';
import 'steps/check_ins/check_in_other_resource.dart';
import 'steps/check_ins/check_in_salary_level.dart';
import 'steps/check_ins/check_in_service_provider_type.dart';
import 'steps/check_ins/check_in_skills_to_improve.dart';
import 'steps/check_ins/check_in_top_priorities.dart';
import 'steps/check_ins/check_in_trade_certifications.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInNavigator navigator;
  OnboardingUseCase onboardingUseCase;
  AppSnackBar snackBar;

  CheckInCubit({
    required this.navigator,
    required this.onboardingUseCase,
    required this.snackBar,
  }) : super(CheckInState.initial());

  BuildContext get context => navigator.context;

  onInit(CheckInInitialParams initialParams) {}

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
        CheckInServiceProvidersAccessed(),
        const CheckInTopPriorities(),
        const CheckInServiceProviderType(),
        const CheckInHousingStatus(),
        const CheckInEducationLevel(),
        const CheckInTradeCertifications(),
        const CheckInSkillsToImprove(),
        const CheckInEmploymentStatus(),
        const CheckInCurrentCareer(),
        const CheckInSalaryLevel(),
        const CheckInCareerChange(),
        const CheckInFutureCareer(),
        const CheckInExpectedSalary(),
        const CheckInOtherResource(),
      ];

  disposeControllers() {
    debugPrint("controller disposed.....");
  }

  bool isNextButtonEnabled() {
    switch (state.checkInSectionIndex) {
      case 0:
        return selectedProviders.isNotEmpty || noServiceProviderAccessedSoFar;
      case 1:
        return selectedTopPriorities.isNotEmpty;
      case 2:
        return selectedServiceProviderSize.isNotEmpty;
      case 3:
        if (selectedHousingStatus.toLowerCase().contains("transitional")) {
          return needOfImmediateHousing.isNotEmpty;
        } else {
          return selectedHousingStatus.isNotEmpty;
        }
      case 4:
        return highestLevelOfEducation.isNotEmpty;
      case 5:
        return tradeCertifications.isNotEmpty;
      case 6:
        if (skillsToImprove.isNotEmpty) {
          if (skillsToImprove.first.title!.contains("Other")) {
            return skillsToImprove.first.value!.isNotEmpty ||
                isNoSkillToImprove;
          }

          return true;
        }
        return false;
      case 7:
        return selectedEmploymentStatus.isNotEmpty;
      case 8:
        return currentCareer != null;
      case 9:
        return currentSalaryLevel.isNotEmpty;
      case 10:
        return lookingForCareerChange.isNotEmpty;
      case 11:
        return careersToPursue.isNotEmpty;
      case 12:
        return expectedSalaryLevel.isNotEmpty;
      case 13:
        return !isOtherResource || otherResource.isNotEmpty;
      case 14:

        /// service provider info
        return true;
      case 15:

        /// service provider info
        return selectedProviders.isNotEmpty || noServiceProviderAccessedSoFar;
      case 16:
        return selectedProviders
            .every((provider) => provider.accessedDate != null);
      default:
        return false;
    }
  }

  nextStepAction() {
    if (isOnboardingCompleted()) {
      _sendOnboardingInformation();
      return;
    }
    if (state.checkInSectionIndex == onBoardingSteps.length - 1) {
      return;
    }
    int step = state.checkInSectionIndex + 1;
    emit(state.copyWith(checkInSectionIndex: step));
  }

  backAction() {
    if (state.checkInSectionIndex == 0) {
      navigator.openExplore(const ExploreInitialParams());
      return;
    }
    int step = state.checkInSectionIndex - 1;
    emit(state.copyWith(checkInSectionIndex: step));
  }

  bool isOnboardingCompleted() {
    if (state.checkInSectionIndex == onBoardingSteps.length - 1) {
      return true;
    }
    if (state.checkInSectionIndex == onBoardingSteps.length - 2 &&
        noServiceProviderAccessedSoFar) {
      return true;
    }

    return false;
  }

  _sendOnboardingInformation() async {
    try {
      emit(state.copyWith(loading: true));
      CurrentNeedsInfo currentNeedInfo = _getCurrentNeedInfo();
      ServiceProviderAccessed serviceProviderAccessed =
          _getServiceProviderAccessed();

      OnboardingInfo onboardingInfo = OnboardingInfo(
        currentNeedsInfo: currentNeedInfo,
        serviceProviderAccessed: serviceProviderAccessed,
      );

      await onboardingUseCase.execute(onboardingInfo);
      snackBar.show("Onboarding submitted successfully",
          snackBarType: SnackBarType.SUCCESS);
      navigator.openExplore(const ExploreInitialParams());
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
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
          skillsToImprove.map((skill) => skill.value.toString()).toList(),
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
