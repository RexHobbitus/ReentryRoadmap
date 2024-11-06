import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/presentation/pages/create_provider/create_provider_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/create_provider/create_provider_navigator.dart';

import '../../../domain/entities/operating_hour.dart';
import '../../../domain/entities/provider.dart';
import '../../../domain/entities/provider_details_info.dart';
import '../../../domain/repositories/database/provider_repository.dart';
import '../popups/information_popup.dart';
import '../popups/provider_location_popup.dart';
import 'create_provider_state.dart';

class CreateProviderCubit extends Cubit<CreateProviderState> {
  CreateProviderNavigator navigator;
  ProviderRepository providerRepository;
  AppSnackBar snackBar;

  CreateProviderCubit(
      {required this.navigator,
      required this.providerRepository,
      required this.snackBar})
      : super(CreateProviderState.initial());

  BuildContext get context => navigator.context;

  final name = TextEditingController();
  final parentLocation = TextEditingController();
  final reentry = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final locationStateTED = TextEditingController();
  final zipCode = TextEditingController();
  final website = TextEditingController();

  String nameProviderLocation = "";
  String describeProviderLocation = "";
  String relationReentry = "";
  String locationStreet = "";
  String locationCity = "";
  String locationCountry = "";
  String locationState = "";
  String locationZipCode = "";

  onInit(CreateProviderInitialParams initialParams) {
    operatingHours = List.generate(
        7,
        (index) => OperatingHour(
              day: daysName[index],
            ));
  }

  List<String> daysName = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];

  List<OperatingHour> operatingHours = [];

  void updateStartTime(int index, DateTime time) {
    operatingHours[index].startTime = time;
    emit(state.copyWith());
  }

  void updateEndTime(int index, DateTime time) {
    operatingHours[index].endTime = time;
    emit(state.copyWith());
  }

  bool _isAllOperatingHoursFilled() {
    for (final operatingHour in operatingHours) {
      if (operatingHour.startTime == null || operatingHour.endTime == null) {
        return false;
      }
    }
    return true;
  }

  notifyTextFieldUpdates() {}

  _validateFields() {
    _isEmpty(name.text.trim(), "Provider name cannot be empty.");
    _isEmpty(parentLocation.text.trim(),
        "Provider location description cannot be empty.");
    _isEmpty(reentry.text.trim(), "Reentry relation cannot be empty.");
    _isEmpty(street.text.trim(), "Street cannot be empty.");
    _isEmpty(city.text.trim(), "City cannot be empty.");
    _isEmpty(country.text.trim(), "Country cannot be empty.");
    _isEmpty(locationStateTED.text.trim(), "State cannot be empty.");

    _isEmpty(zipCode.text.trim(), "Invalid zip code.");
    _isEmpty(website.text.trim(), "Invalid website URL.");
  }

  _isEmpty(String value, String errorMessage) {
    if (value.isEmpty) {
      throw errorMessage;
    }
  }

  addProviderInformation() async {
    try {
      _validateFields();
      emit(state.copyWith(loading: true));
      ProviderDetailsInfo providerDetailsInfo = ProviderDetailsInfo(
          providerNameLocation: name.text.trim(),
          providerLocationDescribe: parentLocation.text.trim(),
          relationReentry: reentry.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          country: country.text.trim(),
          zipCode: zipCode.text.trim(),
          state: locationStateTED.text.trim(),
          orgWebsite: website.text.trim());

      // await checkInUseCase.execute(providerDetailsInfo);
      snackBar.show("CheckIn completed successfully",
          snackBarType: SnackBarType.SUCCESS);
      showConfirmationDialog(name.text.trim());

      /// RESET THIS CUBIT VALUES ALSO FOR NEXT CALL
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  showConfirmationDialog(String name) {
    navigator.navigator.showDialogBox(
        context,
        InformationPopup(
            title: "Thanks for for adding <$name>!",
            subTitle:
                "Our team will verify the information and add the provider"));
  }

  selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
  }

  showProviderLocationDialog() {
    navigator.navigator.showDialogBox(context, const ProviderLocationPopup());
  }
}
