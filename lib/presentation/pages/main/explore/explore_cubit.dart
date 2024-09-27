import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import '../../../../domain/entities/service_category.dart';
import 'explore_initial_params.dart';
import 'explore_state.dart';
import 'explore_navigator.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;
  ExploreCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
  }) : super(ExploreState.initial());

  BuildContext get context => navigator.context;

  List<ServiceCategory>  serviceCategories=[
    ServiceCategory(icon: Assets.education, title: "Education"),
    ServiceCategory(icon: Assets.employment, title: "Employment"),
    ServiceCategory(icon: Assets.housing, title: "Housing"),
    ServiceCategory(icon: Assets.lifeSkills, title: "Life Skills"),
    ServiceCategory(icon: Assets.finance, title: "Finance"),
    ServiceCategory(icon: Assets.legal, title: "Legal"),
    ServiceCategory(icon: Assets.transportation, title: "Transportation"),
    ServiceCategory(icon: Assets.community, title: "Community"),
    ServiceCategory(icon: Assets.health, title: "Health"),
    ServiceCategory(icon: Assets.friendsAndFamily, title: "Friends & Family"),
    ServiceCategory(icon: Assets.spirituality, title: "Spirituality"),
    ServiceCategory(icon: Assets.mentalHealth, title: "Mental Health"),
    ServiceCategory(icon: Assets.firstSteps, title: "First Steps"),
    ServiceCategory(icon: Assets.personalizedServices, title: "Personalized Services"),

  ];
  onInit(ExploreInitialParams initialParams) {
    debugPrint("Explore init called...");
  }


  loginAction() async {
    snackBar.show("Please wait....",snackBarType: SnackBarType.INFO);
    await Future.delayed(const Duration(seconds: 2));
    userStore.setUser(AppUser(id: "123",name: "John",email: "John@email.com"));
    snackBar.show("Logged in successfully.",snackBarType: SnackBarType.SUCCESS);
  }

  signupAction(){
    snackBar.show("Stay tuned....",snackBarType: SnackBarType.SUCCESS);
  }
}
