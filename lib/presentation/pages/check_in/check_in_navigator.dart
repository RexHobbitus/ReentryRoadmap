import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';

class CheckInNavigator with ExploreRoute {
  CheckInNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin OnboardingRoute {
  openOnboarding(CheckInInitialParams initialParams) {
    navigator.push(context, CheckInPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
