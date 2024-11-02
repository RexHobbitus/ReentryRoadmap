import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/domain/usecases/change_password_use_case.dart';

import 'settings_initial_params.dart';
import 'settings_state.dart';
import 'settings_navigator.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;
  ChangePasswordUseCase changePasswordUseCase;

  SettingsCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.changePasswordUseCase,
  }) : super(SettingsState.initial());

  String currentPassword = "", newPassword = "", confirmNewPassword = "";

  BuildContext get context => navigator.context;
  final txtCurrentPassword = TextEditingController(),
      txtNewPassword = TextEditingController(),
      txtConfirmNewPassword = TextEditingController();

  onInit(SettingsInitialParams initialParams) {
    debugPrint("Settings init called...");
  }

  changePasswordAction() async {
    try {
      _getValuesFromTextFields();
      _validatePasswords();
      emit(state.copyWith(loading: true));

      await changePasswordUseCase.execute(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      _resetFields();
      snackBar.show(
        "Password changed successfully",
        snackBarType: SnackBarType.SUCCESS,
      );
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  _getValuesFromTextFields() {
    currentPassword = txtCurrentPassword.text.trim();
    newPassword = txtNewPassword.text.trim();
    confirmNewPassword = txtConfirmNewPassword.text.trim();
  }

  _validatePasswords() {
    if (currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
      throw "Please fill all password fields";
    }

    if (newPassword != confirmNewPassword) {
      throw "New passwords don't match";
    }

    if (currentPassword == newPassword) {
      throw "New password must be different from current password";
    }
  }

  _resetFields() {
    txtCurrentPassword.clear();
    txtNewPassword.clear();
    txtConfirmNewPassword.clear();
    currentPassword = "";
    newPassword = "";
    confirmNewPassword = "";
  }
}
