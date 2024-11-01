import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/settings/settings_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/settings/settings_navigator.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;

  SettingsCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
  }) : super(SettingsInitial());

  BuildContext get context => navigator.context;

  onInit(SettingsInitialParams initialParams) {
    debugPrint("Settings init called...");
  }
}
