import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'inbox_page.dart';
import 'inbox_initial_params.dart';

class InboxNavigator with ExploreRoute, InboxRoute {
  InboxNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin InboxRoute {
  openInbox(InboxInitialParams initialParams) {
    navigator.push(context, InboxPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
