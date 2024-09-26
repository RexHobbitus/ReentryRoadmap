import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'welcome_initial_params.dart';
import 'welcome_state.dart';
import 'welcome_navigator.dart';


class WelcomeCubit extends Cubit<WelcomeState> {
WelcomeNavigator navigator;
WelcomeCubit({required this.navigator}) : super(WelcomeState.initial());

BuildContext get context => navigator.context;

 onInit(WelcomeInitialParams initialParams){

  }

}
