import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'splash_page.dart';
import 'splash_initial_params.dart';

class SplashNavigator with BottomNavRoute{
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
