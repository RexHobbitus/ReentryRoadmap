import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'more_page.dart';
import 'more_initial_params.dart';



class MoreNavigator {
MoreNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin MoreRoute {
openMore(MoreInitialParams initialParams) {

 navigator.push(context, MorePage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
