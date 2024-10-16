import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'explore_page.dart';
import 'explore_initial_params.dart';

class ExploreNavigator with ProviderDetailRoute{
  ExploreNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin ExploreRoute {
  openExplore(ExploreInitialParams initialParams) {
    navigator.go(context, ExplorePage.path, initialParams);
  }


  AppNavigator get navigator;

  BuildContext get context;
}
