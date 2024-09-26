import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../welcome/welcome_navigator.dart';
import 'splash_page.dart';
import 'splash_initial_params.dart';

class SplashNavigator with WelcomeRoute {
  SplashNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin SplashRoute {
  openSplash(SplashInitialParams initialParams) {
    navigator.push(context, SplashPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
