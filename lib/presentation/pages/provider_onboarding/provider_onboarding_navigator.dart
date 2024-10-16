import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_page.dart';
import '../../../../../../core/navigation/app_navigator.dart';
import 'provider_onboarding_initial_params.dart';



class ProviderOnboardingNavigator {
ProviderOnboardingNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin ProviderOnboardingRoute {
openProviderOnboarding(ProviderOnboardingInitialParams initialParams) {

 navigator.push(context, ProviderOnboardingPage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
