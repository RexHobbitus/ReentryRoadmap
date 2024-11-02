import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_initial.dart';


class UserReviewsNavigator {
  UserReviewsNavigator(this.navigator);

  @override
  late AppNavigator navigator;

  @override
  late BuildContext context;
}
  mixin UserReviewsRoute {
  openReview(UserReviewsInitialParams initialParams) {
    navigator.push(context, UserReviews.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
