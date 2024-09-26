import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'bottom_nav_page.dart';
import 'bottom_nav_initial_params.dart';

class BottomNavNavigator {
  BottomNavNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin BottomNavRoute {
  openBottomNav(BottomNavInitialParams initialParams) {
    navigator.push(context, BottomNavPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
