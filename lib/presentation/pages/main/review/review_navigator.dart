import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import 'review_page.dart';
import 'review_initial_params.dart';



class ReviewNavigator {
ReviewNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin ReviewRoute {
openReview(ReviewInitialParams initialParams) {

 navigator.push(context, ReviewPage.path, initialParams);

}

AppNavigator get navigator;

BuildContext get context;
}
