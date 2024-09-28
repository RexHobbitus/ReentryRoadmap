import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'notification_page.dart';
import 'notification_initial_params.dart';



class NotificationNavigator {
NotificationNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin NotificationRoute {
openNotification(NotificationInitialParams initialParams) {

 navigator.push(context, NotificationPage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
