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

  onInit(ExploreInitialParams initialParams) {
    debugPrint("Explore init called...");
  }

}
