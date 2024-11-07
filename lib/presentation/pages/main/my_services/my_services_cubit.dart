import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/domain/repositories/database/my_services_repository.dart';

import 'my_services_initial_params.dart';
import 'my_services_navigator.dart';
import 'my_services_state.dart';

class MyServicesCubit extends Cubit<MyServicesState> {
  MyServicesNavigator navigator;
  MyServicesRepository myServicesRepository;
  AppSnackBar snackBar;
  List<MyService> services = [];
  List<MyService> filteredServices = [];

  MyServicesCubit(
      {required this.navigator,
      required this.myServicesRepository,
      required this.snackBar})
      : super(MyServicesState.initial());

  BuildContext get context => navigator.context;

  onInit(MyServicesInitialParams initialParams) {}

    getMyServices(String id, {MyServicesStatus? myServicesStatus}) async {
    try {
      emit(state.copyWith(loading: true));
      services = await myServicesRepository.getMyServices(userId: id);

      final filteredMyServices = services
          .where((element) {
            if(myServicesStatus != null){
              return removeServices(element.serviceStatus!.name) ==
                  removeServices(myServicesStatus.name).toLowerCase();

            }else{
              return removeServices(element.serviceStatus!.name) ==
                  kMyServicesTabBarItems[0].toLowerCase();

            }
            })
          .toList();
      filteredServices = filteredMyServices;
      emit(state.copyWith(myServices: filteredMyServices));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }



  updateServices(String selectedServiceType) {
    try {
      emit(state.copyWith(loading: true));
      final filteredMyServices = services
          .where((element) {
            // print(selectedServiceType.toLowerCase());
            // print(removeServices(element.serviceStatus!.name));
            return removeServices(element.serviceStatus!.name) ==
              selectedServiceType.toLowerCase();
          })
          .toList();
      filteredServices = filteredMyServices;
      emit(state.copyWith(myServices: filteredMyServices));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  String removeServices(String text) {
    // Define the regex pattern to match 'services' anywhere in the string
    RegExp regExp = RegExp(r'services', caseSensitive: false);

    // Remove the keyword "services"
    String filteredText = text.replaceAll(regExp, '').trim();

    return filteredText;
  }
}
