import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'notification_initial_params.dart';
import 'notification_state.dart';
import 'notification_navigator.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;

  NotificationCubit({
    required this.navigator,
    required this.snackBar,
    required this.userStore,
  }) : super(NotificationState.initial());

  BuildContext get context => navigator.context;

  onInit(NotificationInitialParams initialParams) {}
}
