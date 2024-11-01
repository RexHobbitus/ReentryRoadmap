import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/settings/settings_initial_params.dart';

import '../../../../domain/entities/provider.dart';
import '../profile/profile_initial_params.dart';
import 'account_initial_params.dart';
import 'account_navigator.dart';

part 'Account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;

  AccountCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
  }) : super(AccountInitial());

  BuildContext get context => navigator.context;

  onInit(AccountInitialParams initialParams) {
    debugPrint("Account init called...");
  }

  openSettings() {
    navigator.openSettings(const SettingsInitialParams());
  }

  openProfile() {
    navigator.openProfile(const ProfileInitialParams());
  }
}
