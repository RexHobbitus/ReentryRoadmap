import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_navigator.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../check_in/check_in_navigator.dart';
import 'explore_initial_params.dart';
import 'explore_page.dart';

class ExploreNavigator with ProviderDetailRoute, CheckInRoute, SearchRoute {
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
