import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/general_service.dart';
import 'package:reentry_roadmap/domain/entities/operating_hour.dart';
import 'package:reentry_roadmap/domain/entities/provider_details_info.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/domain/usecases/provider_onboarding_use_case.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/popups/information_popup.dart';
import 'package:reentry_roadmap/presentation/pages/popups/upload_photos_popup.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_state.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_offer_program/program_service_program_offer_eligibility_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_offer_program/program_service_program_offer_features_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_offer_program/program_service_program_offer_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_offer_program/program_service_program_offer_describe_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_offer_program/program_service_program_offer_apply_catagories_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/program_offer_program/program_service_program_offer_subCatagory_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/general_service/program_service_general_service_catagories_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/general_service/program_service_general_service_eligibility_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/general_service/program_service_general_service_features_section.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/steps/program_service/general_service/program_service_general_service_intro_section.dart';
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

import '../../../domain/entities/program.dart';
import 'steps/program_service/general_service/program_service_general_service_subcategories_section.dart';

class ProviderOnboardingCubit extends Cubit<ProviderOnboardingState> {
  ProviderOnboardingNavigator navigator;
  ProviderOnboardingUseCase providerOnboardingUseCase;
  AppSnackBar snackBar;

  ProviderOnboardingCubit(
      {required this.navigator,
      required this.providerOnboardingUseCase,
      required this.snackBar})
      : super(ProviderOnboardingState.initial());

  BuildContext get context => navigator.context;

  onInit(ProviderOnboardingInitialParams initialParams) {
    operatingHours = List.generate(
        7,
        (index) => OperatingHour(
              day: daysName[index],
            ));
  }

  //provider onboarding
  String nameProviderLocation = "";
  String describeProviderLocation = "";
  String relationReentry = "";
  String locationStreet = "";
  String locationCity = "";
  String locationCountry = "";
  String locationState = "";
  String locationZipCode = "";

  String officialPhone = "";
  String officialEmail = "";
  String faxNumber = "";
  String contactPerson = "";
  String orgWebsite = "";

  List<String> daysName = ["SUN", "MON", "TUE", "WED", "THUR", "FRI", "SAT"];

  List<OperatingHour> operatingHours = [];

  void updateStartTime(int index, DateTime time) {
    operatingHours[index].startTime = time;
    emit(state.copyWith());
  }

  void updateEndTime(int index, DateTime time) {
    operatingHours[index].endTime = time;
    emit(state.copyWith());
  }

//program services

  String specificProgram = "";

//amazing sauce program
  List<Program> selectedPrograms = [];
  GeneralService generalServiceInfo = GeneralService(
    serviceCategories: [],
    features: [],
    eligibilityCriteria: [],
  );

  List<List<ServiceCategory>> selectedCategories = [];
  List<ServiceCategory> selectedCategoriesForGeneralService = [];

  List<String> programOfferSubCategories = [];

  List<String> generalServiceSubCategories = [];
  List<String> generalServiceProgramFeatures = [];
  List<String> generalServiceEligibilityCriteria = [];
  final textFieldUpdateListener = StreamController<bool>.broadcast();

  notifyTextFieldUpdates() {
    textFieldUpdateListener.add(true);
  }

  List<Widget> get onBoardingSteps => [
        /// 1st part
        //Provider Onboarding
        const ProviderDetailsIntro(),
        const ProviderDetailNameLocationSection(),
        const ProviderDescribeLocationWidget(),
        const ProviderOnboardingReenteryRelationSection(),
        ProviderOnboardingLocationSection(),
        ProviderOperatingHours(),
        ProviderDetailImageUploadSection(),

        const ProviderOfficialPhoneSection(),
        const ProviderOfficialEmailSection(),
        const ProviderOfficialFaxSection(),
        const ProviderOfficialContactPersonSection(),
        const ProviderOrgWebSection(),

        //2nd part
        //  provider  program service
        const ProgramServiceIntroSection(),
        const ProgramServiceSpecificProgramSection(),
        ProgramServiceProgramOfferSection(),

        // //amazing sausce progra,
        for (int programIndex = 0;
            programIndex < selectedPrograms.length;
            programIndex++) ...[
          ProgramServiceAboutProgramOfferSection(
            index: programIndex,
          ),
          ProgramServiceProgramOfferDescribeSection(
            index: programIndex,
          ),
          ProgramServiceProgramOfferApplyCatagoriesSection(
            index: programIndex,
          ),
          ProgramServiceProgramOfferSubcatagorySection(
            index: programIndex,
          ),
          ProgramServiceProgramOfferFeaturesSection(
            index: programIndex,
          ),
          ProgramServiceProgramOfferEligibilitySection(
            index: programIndex,
          ),
        ],

        // //general services
        const ProgramServiceGeneralServiceIntroSection(),
        const ProgramServiceGeneralServiceCatagoriesSection(),
        const ProgramServiceGeneralServiceSubCategoriesSection(),
        ProgramServiceGeneralServiceFeaturesSection(),
        ProgramServiceGeneralServiceEligibilitySection()
      ];

  disposeControllers() {
    debugPrint("controller disposed.....");
  }

  skipStepAction() {
    int step = state.providerOnboardingSectionIndex + 1;
    emit(state.copyWith(providerOnboardingSectionIndex: step));
  }

  nextStepAction() {
    if (isProviderOnboardingCompleted()) {
      _sendOnboardingInformation();
      return;
    }
    if (state.providerOnboardingSectionIndex == onBoardingSteps.length - 1) {
      return;
    }

    int step = state.providerOnboardingSectionIndex + 1;
    emit(state.copyWith(providerOnboardingSectionIndex: step));
  }

  backAction() {
    int step = state.providerOnboardingSectionIndex - 1;
    emit(state.copyWith(providerOnboardingSectionIndex: step));
  }

  _sendOnboardingInformation() async {
    try {
      emit(state.copyWith(loading: true));

      ProviderDetailsInfo providerDetailsInfo = _getProviderDetailsInfo();

      ProviderOnboardingInfo providerOnboardingInfo = ProviderOnboardingInfo(
        providerDetails: providerDetailsInfo,
        // programs: selectedPrograms,
        // generalService: generalServiceInfo,
      );

      await providerOnboardingUseCase.execute(
          providerOnboardingInfo, state.providerLocationImages);
      snackBar.show("Provider Onboarding submitted successfully",
          snackBarType: SnackBarType.SUCCESS);

      navigator.openExplore(const ExploreInitialParams());
      navigator.navigator.showDialogBox(
          context,
          InformationPopup(
              title: "Thanks for creating a business account!",
              subTitle:
                  "Our team will verify the information and get back to you in 2-3 business days"));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  bool isProviderOnboardingCompleted() {
    if (state.providerOnboardingSectionIndex == onBoardingSteps.length - 1) {
      return true;
    }

    return false;
  }

  bool isNextButtonEnabled() {
    switch (state.providerOnboardingSectionIndex) {
      case 0:

        /// Provider Details Info
        return true;
      case 1:
        return nameProviderLocation.isNotEmpty;
      case 2:
        return describeProviderLocation.isNotEmpty;
      case 3:
        return relationReentry.isNotEmpty;
      case 4:
        return locationCity.isNotEmpty &&
            locationState.isNotEmpty &&
            locationCountry.isNotEmpty &&
            locationZipCode.isNotEmpty;
      case 5:
        return _isAllOperatingHoursFilled();
      // return startTime != null && endTime != null;

      case 6:
        return state.providerLocationImages.isNotEmpty;
      case 7:
        return officialPhone.isNotEmpty;
      case 8:
        return officialEmail.isNotEmpty;
      case 9:
        return faxNumber.isNotEmpty;
      case 10:
        return contactPerson.isNotEmpty;
      case 11:
        return orgWebsite.isNotEmpty;

      case 12:

        /// program services

        return true;
      case 13:
        return specificProgram.isNotEmpty;
      case 14:
        for (int i = 0; i < selectedPrograms.length; i++) {
          var program = selectedPrograms[i];

          if (program.name == null) {
            return false;
          }
        }
        return true;

      case 15:

        /// amazing sauce program
        return true;

      case 16:
        // for (var program in selectedPrograms) {
        //   if (program.description == null || program.description!.isEmpty) {
        //     return false;
        //   }
        // }
        return true;
      // return false;
      case 17:
        // for (var categories in selectedCategories) {
        //   if (categories.isEmpty) {
        //     return false;
        //   }
        // }
        return true;

      case 18:
        // for (var programOfferSubCategories in selectedCategories) {
        //   if (programOfferSubCategories.isEmpty) {
        //     return false;
        //   }
        // }

        return true;

      /// TODO: WE  HAVE TO APPLY CHECK FOR ALL SUB CATEGORIES SELECTED
      case 19:
        return true;
      case 20:

        /// TODO: WE  HAVE TO FIX THIS
        return true;
      case 21:
        return true;
      default:
        return true;
    }
  }

  bool _isAllOperatingHoursFilled() {
    for (final operatingHour in operatingHours) {
      if (operatingHour.startTime == null || operatingHour.endTime == null) {
        return false;
      }
    }
    return true;
  }

  ProviderDetailsInfo _getProviderDetailsInfo() {
    return ProviderDetailsInfo(
      // providerNameLocation: nameProviderLocation,
      // providerLocationDescribe: describeProviderLocation,
      // relationReentry: relationReentry,
      // street: locationStreet,
      // city: locationCity,
      // country: locationCountry,
      // state: locationState,
      // zipCode: locationZipCode,
      images: [],
      // contactPerson: contactPerson,
      // officialNumber: officialPhone,
      // officialEmail: officialEmail,
      // officialFax: faxNumber,
      // orgWebsite: orgWebsite,
      // ratings: '0',
      // reviews: [],
      // operatingHours: operatingHours,
    );
  }

  openImagePicker() {
    navigator.navigator.showDialogBox(context, UploadPhotosPopup(
      onUpload: (files) {
        emit(state.copyWith(providerLocationImages: files));
      },
    ));
  }

  removeImage(dynamic image) {
    List<dynamic> updatedImages = List.from(state.providerLocationImages);
    updatedImages.remove(image);
    emit(state.copyWith(providerLocationImages: updatedImages));
  }
}
