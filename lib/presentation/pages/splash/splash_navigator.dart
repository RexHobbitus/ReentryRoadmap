import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../create_provider/create_provider_navigator.dart';
import 'splash_page.dart';
import 'splash_initial_params.dart';

class SplashNavigator
    with
        ExploreRoute,
        OnboardingRoute,
        ProviderOnboardingRoute,
        CreateProviderRoute {
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
