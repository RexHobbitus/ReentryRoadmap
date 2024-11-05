import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'learn_more_page.dart';
import 'learn_more_initial_params.dart';



class LearnMoreNavigator {
LearnMoreNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin LearnMoreRoute {
openLearnMore(LearnMoreInitialParams initialParams) {

 navigator.push(context, LearnMorePage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
