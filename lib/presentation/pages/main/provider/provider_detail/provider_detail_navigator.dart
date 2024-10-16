import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'provider_detail_page.dart';
import 'provider_detail_initial_params.dart';

class ProviderDetailNavigator {
  ProviderDetailNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin ProviderDetailRoute {
  openProviderDetail(ProviderDetailInitialParams initialParams) {
    navigator.push(context, ProviderDetailPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
