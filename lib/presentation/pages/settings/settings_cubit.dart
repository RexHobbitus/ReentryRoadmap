import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/entities/data_sharing_settings.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/domain/usecases/change_password_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/update_data_sharing_settings_use_case.dart';

import 'settings_initial_params.dart';
import 'settings_state.dart';
import 'settings_navigator.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;
  ChangePasswordUseCase changePasswordUseCase;
  UpdateDataSharingSettingsUseCase updateDataSharingSettingsUseCase;
  AppUserRepository userRepository;

  SettingsCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.changePasswordUseCase,
    required this.updateDataSharingSettingsUseCase,
    required this.userRepository,
  }) : super(SettingsState.initial());

  UserDataSharingSettings originalSettings = UserDataSharingSettings.defaultSettings();
  String currentPassword = "", newPassword = "", confirmNewPassword = "";
  bool shareEverything = true;
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

  getSettings() async {
    try {
      emit(state.copyWith(loading: true));
      UserDataSharingSettings settings = await userRepository.getUserDataSharingSettings();
      originalSettings = settings;
      emit(state.copyWith(userDataSharingSettings: settings, shareEverything: settings.shareEverything));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  bool get hasSettingsChanged {
    return state.userDataSharingSettings != originalSettings;
  }

  updateDataSharingSettingsAction() async {
    try {
      emit(state.copyWith(loading: true));
      await updateDataSharingSettingsUseCase.execute(state.userDataSharingSettings);
      originalSettings = state.userDataSharingSettings;
      snackBar.show("Settings updated successfully", snackBarType: SnackBarType.SUCCESS);
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  toogleUserDataSharingSetting(UserDataSharingSettings settings) {
    emit(state.copyWith(
      userDataSharingSettings: settings,
    ));
  }

  void toggleShareEverything(bool value) {
    final updatedSettings = value
        ? UserDataSharingSettings.defaultSettings() // Set all fields to default when sharing everything
        : UserDataSharingSettings.defaultOfftSettings(); // Set all fields to off when sharing nothing

    emit(state.copyWith(
      userDataSharingSettings: updatedSettings,
      shareEverything: value,
    ));
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

  void toggleCurrentPasswordVisibility() {
    emit(state.copyWith(
      currentPasswordVisible: !state.currentPasswordVisible,
    ));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(
      newPasswordVisible: !state.newPasswordVisible,
    ));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
      confirmPasswordVisible: !state.confirmPasswordVisible,
    ));
  }
}
