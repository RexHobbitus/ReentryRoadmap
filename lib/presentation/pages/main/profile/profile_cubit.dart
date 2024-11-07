import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/onboarding_info.dart';
import 'package:reentry_roadmap/domain/entities/user_profile_update.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/usecases/logout_use_case.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_initial_params.dart';
import '../../../../domain/entities/app_user.dart';
import '../../../../domain/entities/career.dart';
import '../../../../domain/entities/current_needs_info.dart';
import '../../../../domain/entities/personal_info.dart';
import '../../../../domain/entities/service_provider.dart';
import '../../check_in/steps/check_ins/check_in_skills_to_improve.dart';
import 'profile_initial_params.dart';
import 'profile_state.dart';
import 'profile_navigator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileNavigator navigator;
  AppUserRepository appUserRepository;
  AuthRepository authRepository;
  LogoutUseCase logoutUseCase;

  ProfileCubit({
    required this.navigator,
    required this.logoutUseCase,
    required this.appUserRepository,
    required this.authRepository,
  }) : super(ProfileState.initial());

  BuildContext get context => navigator.context;

  onInit(ProfileInitialParams initialParams) {
    _getUserInfo();
  }

  openMore() {
    navigator.openMore(const MoreInitialParams());
  }

  /// Personal Details section
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String email = "";

  DateTime? selectedDob;
  String selectedEthnicity = "";
  String selectedGender = "";
  String selectedVeteran = "";
  String locationStreet = "";
  String locationCity = "";
  String locationState = "";
  String phoneNumber = "";

  /// Incarceration Details Section
  String idType = "";
  String idNumber = "";
  String numberOfTimesIncarcerated = "";
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

  /// Current needs Section
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

  /// Service Providers info
  List<ServiceProvider> selectedProviders = [];
  bool noServiceProviderAccessedSoFar = false;
  final List<String> topPriorities = [
    "Education",
    "Employment",
    "Housing",
    "Life Skills",
    "Finance",
    "Legal",
    "Transportation",
    "Community",
    "Health",
  ];
  final List<String> serviceProviderSizes = ["Small (0-50)", "Medium (50-250)", "Large (250+)"];
  final List<String> housingStatues = [
    "Housing Insecure",
    "Transitional Housing",
    "Living with family/friends",
    "Renting or owning a home"
  ];
  final List<String> educationLevels = [
    "Working to GED",
    "High School Diploma or GED",
    "Some College",
    "Associated Degree",
    "Bachelor’s Graduate",
    "Graduate School and Beyond"
  ];

  final List<String> certifications = [
    "None",
    "OSHA",
    "CDL",
    "HVAC",
    "Building Maintenance",
    "Plumbing",
    "ServSafe",
    "CNA",
  ];

  final List<SkillToImprove> skillsToImproveAll = [
    SkillToImprove(
      title: "Digital Skills",
      subTitle: "Computer literacy, IT, etc",
      value: "Digital Skills",
    ),
    SkillToImprove(title: "Financial Skills", subTitle: "Budgeting, managing money, etc", value: "Financial Skills"),
    SkillToImprove(
        title: "Technical or trade skills", subTitle: "Plumbing, Welding, etc", value: "Technical or trade skills"),
    SkillToImprove(
      title: "Professional skills",
      subTitle: "Resume writing, communication",
      value: "Professional skills",
    ),
    SkillToImprove(
      title: "Other/ None",
      subTitle: "",
      value: "",
    ),
  ];
  final List<String> employmentOptions = ["Yes, employed full-time", "Yes, employed part-time", "No, not employed"];
  final List<Career> careers = [
    Career(title: "Service", subTitle: "Restaurants, healthcare, retail shops, etc"),
    Career(title: "Administrative/Office Support", subTitle: "Clerical work, data entry, reception, office management"),
    Career(title: "Labor/ Manufacturing", subTitle: "Factory work, construction, warehousing, etc"),
    Career(title: "Sales/Marketing", subTitle: "Sales roles, marketing positions, business development"),
    Career(title: "Skilled Trades", subTitle: "Electrical work, plumbing, carpentry, etc"),
    Career(title: "Information Technology (IT)", subTitle: "IT support, software development, technical services"),
  ];
  final List<String> salaryRanges = [
    "Working for free",
    "Less than \$25,000",
    "\$25,000 - \$50,000",
    "\$50,000 - \$100,000",
    "\$100,000 +"
  ];

  final List<String> expectedSalaryRanges = [
    "Less than \$25,000",
    "\$25,000 - \$50,000",
    "\$50,000 - \$100,000",
    "\$100,000 +"
  ];

  final textFieldUpdateListener = StreamController<bool>.broadcast();

  notifyTextFieldUpdates() {
    textFieldUpdateListener.add(true);
  }

  String fullName() => '$firstName $middleName $lastName';

  _getUserInfo() async {
    try {
      emit(state.copyWith(loading: true));

      LoginUser? loginUser = await authRepository.getCurrentUser();
      AppUser? user = loginUser?.data as AppUser?;

      if (user != null && user.onboardingInfo != null) {
        OnboardingInfo onboardingInfo = user.onboardingInfo!;

        // Set Personal Information
        final personalInfo = onboardingInfo.personalInfo;
        if (personalInfo != null) {
          firstName = personalInfo.firstName ?? "";
          middleName = personalInfo.middleName ?? "";
          lastName = personalInfo.lastName ?? "";
          selectedDob = personalInfo.dateOfBirth;
          selectedEthnicity = personalInfo.ethnicity ?? "";
          selectedGender = personalInfo.gender ?? "";
          selectedVeteran = personalInfo.veteranStatus ?? "";
          locationStreet = personalInfo.street ?? "";
          locationCity = personalInfo.city ?? "";
          locationState = personalInfo.state ?? "";
          phoneNumber = personalInfo.phoneNumber ?? "";
          email = user.email ?? '';
        }

        // Set Incarceration Information
        final incarcerationInfo = onboardingInfo.incarcerationInfo;
        if (incarcerationInfo != null) {
          idType = incarcerationInfo.idType ?? "";
          idNumber = incarcerationInfo.idNumber ?? "";
          numberOfTimesIncarcerated = incarcerationInfo.numberOfTimesIncarcerated ?? '';
          selectedIncarceratedBefore = incarcerationInfo.numberOfTimesIncarcerated ?? "";
          selectedIncarceratedHistory = incarcerationInfo.incarceratedHistory ?? "";
          selectedTypeOfOffences = incarcerationInfo.latestOffenceType ?? [];
          selectedLongestIncarcerationLength = incarcerationInfo.lengthOfLongestIncarceration ?? "";
          selectedLatestIncarcerationLength = incarcerationInfo.lengthOfLatestIncarceration ?? "";
          firstIncarceratedDate = incarcerationInfo.firstIncarcerationDate;
          latestReleaseDate = incarcerationInfo.latestReleaseDate;
          selectedServeMost = incarcerationInfo.mostRecentTermServerIn ?? "";
          selectedPrograms = incarcerationInfo.programAttendedWhileIncarcerated ?? [];
        }

        // Set Current Needs Information
        final currentNeedsInfo = onboardingInfo.currentNeedsInfo;
        if (currentNeedsInfo != null) {
          selectedTopPriorities = currentNeedsInfo.currentTopPriorities ?? [];
          selectedServiceProviderSize = currentNeedsInfo.preferredServiceProviderSize ?? "";
          selectedHousingStatus = currentNeedsInfo.currentHousingStatus ?? "";
          needOfImmediateHousing = currentNeedsInfo.needOfImmediateHousing ?? "";
          highestLevelOfEducation = currentNeedsInfo.highestLevelOfEducation ?? "";
          tradeCertifications = currentNeedsInfo.tradeCertifications ?? [];

          // Convert skills to improve to the correct format
          skillsToImprove = (currentNeedsInfo.skillsToImproveOn ?? [])
              .map((skill) => SkillToImprove(title: skill, value: skill))
              .toList();

          selectedEmploymentStatus = currentNeedsInfo.currentEmploymentStatus ?? "";
          if (currentNeedsInfo.currentCareerStatus != null) {
            currentCareer = Career(title: currentNeedsInfo.currentCareerStatus!);
          }
          currentSalaryLevel = currentNeedsInfo.currentSalaryStatus ?? "";
          lookingForCareerChange = currentNeedsInfo.lookingForCareerChange ?? "";

          // Convert aspiring careers to Career objects
          careersToPursue =
              (currentNeedsInfo.aspiringCareerTrack ?? []).map((career) => Career(title: career)).toList();

          expectedSalaryLevel = currentNeedsInfo.aspiringSalaryLevel ?? "";
          otherResource = currentNeedsInfo.otherResourceWanted ?? "";
        }

        // Set Service Provider Information
        final serviceProviderInfo = onboardingInfo.serviceProviderAccessed;
        if (serviceProviderInfo != null) {
          selectedProviders = serviceProviderInfo.serviceProviders ?? [];
          noServiceProviderAccessedSoFar = selectedProviders.isEmpty;
        }

        // Notify UI of updates
        notifyTextFieldUpdates();
        emit(state.copyWith(
          loading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  logoutAction() async {
    await logoutUseCase.execute();
  }

  editAction() {
    emit(state.copyWith(edit: true));
  }

  saveAction() async {
    try {
      emit(state.copyWith(loading: true));

      // Create updated onboarding info
      final updatedOnboardingInfo = UserProfileUpdateInfo(
        personalInfo: _getPersonalInformation(),
        currentNeedsInfo: _getCurrentNeedInfo(),
      );

      // Update user information in repository
      await appUserRepository.updateUserProfileInfo(updatedOnboardingInfo);

      emit(state.copyWith(
        loading: false,
        edit: false,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  // Helper methods to create entity objects
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

  CurrentNeedsInfo _getCurrentNeedInfo() {
    return CurrentNeedsInfo(
      currentTopPriorities: selectedTopPriorities,
      preferredServiceProviderSize: selectedServiceProviderSize,
      currentHousingStatus: selectedHousingStatus,
      needOfImmediateHousing: needOfImmediateHousing,
      highestLevelOfEducation: highestLevelOfEducation,
      tradeCertifications: tradeCertifications,
      skillsToImproveOn: skillsToImprove.map((skill) => skill.value.toString()).toList(),
      currentEmploymentStatus: selectedEmploymentStatus,
      currentCareerStatus: currentCareer?.title,
      currentSalaryStatus: currentSalaryLevel,
      lookingForCareerChange: lookingForCareerChange,
      aspiringCareerTrack: careersToPursue.map((career) => career.title.toString()).toList(),
      aspiringSalaryLevel: expectedSalaryLevel,
      otherResourceWanted: otherResource,
    );
  }

  @override
  Future<void> close() {
    textFieldUpdateListener.close();
    return super.close();
  }
}
