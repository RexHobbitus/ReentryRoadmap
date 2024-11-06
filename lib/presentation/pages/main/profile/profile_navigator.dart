import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../more/more_navigator.dart';
import 'profile_page.dart';
import 'profile_initial_params.dart';

class ProfileNavigator with MoreRoute {
  ProfileNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin ProfileRoute {
  openProfile(ProfileInitialParams initialParams) {
    navigator.push(context, ProfilePage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
