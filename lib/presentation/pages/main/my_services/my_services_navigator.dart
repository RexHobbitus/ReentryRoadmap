import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/login/login_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_navigator.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'my_services_page.dart';
import 'my_services_initial_params.dart';



class MyServicesNavigator with LoginRoute, SignUpRoute{
MyServicesNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin MyServicesRoute {
openMyServices(MyServicesInitialParams initialParams) {

 navigator.push(context, MyServicesPage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
