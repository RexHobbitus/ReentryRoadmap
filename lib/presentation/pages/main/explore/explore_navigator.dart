import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'explore_page.dart';
import 'explore_initial_params.dart';

class ExploreNavigator {
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
