import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_state.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/amazing_sauce_program/program_service_amazing_program_features_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/amazing_sauce_program/program_service_amazing_program_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/amazing_sauce_program/program_service_amazing_sauce_describe_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/amazing_sauce_program/program_service_apply_catagories_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/amazing_sauce_program/program_service_subCatagory_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_service_intro_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_service_program_offer_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_service_specific_program_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_detail_describe_location_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_detail_image_upload_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_detail_name_location_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_details_intro.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_detail_operating_hours.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_official_contact_person_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_official_email_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_official_fax_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_official_phone_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_onboarding_location_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_onboarding_reentery_relation_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/provider_details/provider_org_web_section.dart';

class ProviderOnboardingCubit extends Cubit<ProviderOnboardingState> {
  ProviderOnboardingNavigator navigator;
  ProviderOnboardingCubit({required this.navigator})
      : super(ProviderOnboardingState.initial());

  BuildContext get context => navigator.context;

  onInit(ProviderOnboardingInitialParams initialParams) {}

  //provider onboarding
  String nameProviderLocation = "";
  String describeProviderLocation = "";
  String relationReentry = "";
  String locationStreet = "";
  String locationCity = "";
  String locationCountry = "";
  String locationState = "";
  String locationZipCode = "";
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  List<String> providerLocationPhotos = [];
  String officialPhone = "";
  String officialEmail = "";
  String faxNumber = "";
  String contactPerson = "";
  String orgWebsite = "";

  List<TimeOfDay?> startTimes = List.generate(7, (index) => null);
  List<TimeOfDay?> endTimes = List.generate(7, (index) => null);

  void updateStartTime(int index, TimeOfDay time) {
    startTimes[index] = time;
    emit(state.copyWith());
  }

  void updateEndTime(int index, TimeOfDay time) {
    endTimes[index] = time;
    emit(state.copyWith());
  }
//program services

  String specificProgram = "";
  List<String> programOffer = [];
  final textFieldUpdateListener = StreamController<bool>.broadcast();

//amazing sauce program
  List<ServiceCategory> catagoriesList = kServiceCategories;
  String amazingSauceDetail = '';
  List<String> categories = [];
  List<String> subCategories = [];
  List<String> programFeatures = [];
  List<String> eligibilityCriteria = [];

  notifyTextFieldUpdates() {
    textFieldUpdateListener.add(true);
  }

  List<Widget> get onBoardingSteps => [
        /// 1st part
        //Provider Onboarding
        const ProviderDetailsIntro(),
        const ProviderDetailNameLocationSection(),
        const ProviderOnboardingReenteryRelationSection(),
        const ProviderDescribeLocationWidget(),
        ProviderOperatingHours(),
        ImageUploadScreen(),
        ProviderOnboardingLocationSection(),
        const ProviderOfficialPhoneSection(),
        const ProviderOfficialEmailSection(),
        const ProviderOfficialFaxSection(),
        const ProviderOfficialContactPersonSection(),
        const ProviderOrgWebSection(),

        //2nd part
        //provider  program service
        const ProgramServiceIntroSection(),
        const ProgramServiceSpecificProgramSection(),
        ProgramServiceProgramOfferSection(),

        //amazing sausce progra,
        const ProgramServiceAmazingProgramSection(),
        const ProgramServiceAmazingSauceDescribeSection(),
        ProgramServiceApplyCategoriesSection(),
        const ProgramServiceSubcatagorySection(),
        ProgramServiceAmazingProgramFeaturesSection(),
      ];
  disposeControllers() {
    debugPrint("controller disposed.....");
  }

  void addCategory(String category) {
    categories.add(category);
    emit(state.copyWith()); 
  }

  void removeCategory(String category) {
    categories.remove(category);
    emit(state.copyWith()); 
  }
  bool isCategorySelected(String category) {
    return categories.contains(category);
  }

  nextStepAction() {
    int step = state.providerOnboardingSectionIndex + 1;
    emit(state.copyWith(providerOnboardingSectionIndex: step));
  }

  backAction() {
    int step = state.providerOnboardingSectionIndex - 1;
    emit(state.copyWith(providerOnboardingSectionIndex: step));
  }
}
