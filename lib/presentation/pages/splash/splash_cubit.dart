import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_initial_params.dart';
import 'splash_initial_params.dart';
import 'splash_state.dart';
import 'splash_navigator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashNavigator navigator;

  SplashCubit({required this.navigator}) : super(SplashState.initial());

  BuildContext get context => navigator.context;

  onInit(SplashInitialParams initialParams) {
    _navigateToBottomNav();
  }

  _navigateToBottomNav() {
    Future.delayed(const Duration(seconds: 2)).then((val){
      navigator.openBottomNav(const BottomNavInitialParams());
    });
  }
}
