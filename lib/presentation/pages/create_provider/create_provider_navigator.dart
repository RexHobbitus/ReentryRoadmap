import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_initial_params.dart';

import '../main/explore/explore_navigator.dart';
import 'create_provider_initial_params.dart';
import 'create_provider_page.dart';

class CreateProviderNavigator with ExploreRoute {
  CreateProviderNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin CreateProviderRoute {
  openCreateProvider(CreateProviderInitialParams initialParams) {
    navigator.push(context, CreateProviderPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
