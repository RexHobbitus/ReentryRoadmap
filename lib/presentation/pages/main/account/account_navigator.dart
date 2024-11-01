import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/settings/settings_navigator.dart';

import '../../../../../core/navigation/app_navigator.dart';
import 'Account_initial_params.dart';
import 'Account_page.dart';

class AccountNavigator with SettingsRoute, ProfileRoute {
  AccountNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin AccountRoute {
  openAccount(AccountInitialParams initialParams) {
    navigator.push(context, AccountPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
