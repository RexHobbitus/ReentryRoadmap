import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'welcome_page.dart';
import 'welcome_initial_params.dart';



class WelcomeNavigator {
WelcomeNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin WelcomeRoute {
openWelcome(WelcomeInitialParams initialParams) {

 navigator.push(context, WelcomePage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
