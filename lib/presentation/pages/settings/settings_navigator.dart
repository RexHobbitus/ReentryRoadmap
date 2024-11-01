import 'package:flutter/material.dart';

import '../../../core/navigation/app_navigator.dart';
import 'settings_initial_params.dart';
import 'settings_page.dart';

class SettingsNavigator {
  SettingsNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin SettingsRoute {
  openSettings(SettingsInitialParams initialParams) {
    navigator.push(context, SettingsPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
