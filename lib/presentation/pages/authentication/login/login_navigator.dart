import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'login_page.dart';
import 'login_initial_params.dart';

class LoginNavigator with OnboardingRoute,ExploreRoute,ProviderOnboardingRoute{
  LoginNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin LoginRoute {
  openLogin(LoginInitialParams initialParams) {
    navigator.push(context, LoginPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
