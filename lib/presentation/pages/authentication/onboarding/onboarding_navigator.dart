import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'onboarding_page.dart';
import 'onboarding_initial_params.dart';



class OnboardingNavigator {
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
