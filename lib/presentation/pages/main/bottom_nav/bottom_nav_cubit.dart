import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/notification/notification_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_page.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';
import 'bottom_nav_initial_params.dart';
import 'bottom_nav_state.dart';
import 'bottom_nav_navigator.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;
  BottomNavCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,

  }) : super(BottomNavState.initial());

  BuildContext get context => navigator.context;

  onInit(BottomNavInitialParams initialParams) {}

  loginAction() async {
      navigator.openLogin(const LoginInitialParams());
  }


  void setActiveIndex(int index){
    emit(state.copyWith(currentIndex: index));
  }
  void onMenuTapped(int index, BuildContext context) {
    emit(state.copyWith(currentIndex: index));
    switch (index) {
      case 0:
        GoRouter.of(context).go(ExplorePage.path);
      case 1:
        GoRouter.of(context).go(MyServicesPage.path);
      case 2:
        GoRouter.of(context).go(ProfilePage.path);
      case 3:
        GoRouter.of(context).go(ReviewPage.path);
      case 4:
        GoRouter.of(context).go(MorePage.path);
    }
  }


  notificationAction(){
    navigator.openNotification(const NotificationInitialParams());
  }

  signUpAction(){
    navigator.openSignUp(const SignUpInitialParams());
  }
}
