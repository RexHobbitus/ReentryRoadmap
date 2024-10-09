import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'onboarding_page.dart';
import 'onboarding_initial_params.dart';



class OnboardingNavigator with  ExploreRoute{
OnboardingNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin OnboardingRoute {
openOnboarding(OnboardingInitialParams initialParams) {

 navigator.push(context, OnboardingPage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
