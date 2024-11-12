import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'my_services_initial_params.dart';
import 'my_services_state.dart';
import 'my_services_navigator.dart';


class MyServicesCubit extends Cubit<MyServicesState> {
MyServicesNavigator navigator;
MyServicesCubit({required this.navigator}) : super(MyServicesState.initial());

BuildContext get context => navigator.context;

 onInit(MyServicesInitialParams initialParams){

  }

}
