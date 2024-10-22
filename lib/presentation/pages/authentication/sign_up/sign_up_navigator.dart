import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'sign_up_page.dart';
import 'sign_up_initial_params.dart';



class SignUpNavigator with OnboardingRoute,ProviderOnboardingRoute{
SignUpNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin SignUpRoute {
openSignUp(SignUpInitialParams initialParams) {

 navigator.push(context, SignUpPage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
