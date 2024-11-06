import '../../../domain/entities/data_sharing_settings.dart';

class SettingsState {
  final bool loading;
  final bool currentPasswordVisible;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;
  final UserDataSharingSettings userDataSharingSettings;
  final bool shareEverything;

  const SettingsState({
    required this.loading,
    required this.currentPasswordVisible,
    required this.newPasswordVisible,
    required this.confirmPasswordVisible,
    required this.userDataSharingSettings,
    required this.shareEverything,
  });

  factory SettingsState.initial() => SettingsState(
        loading: false,
        currentPasswordVisible: false,
        newPasswordVisible: false,
        confirmPasswordVisible: false,
        shareEverything: true,
        userDataSharingSettings: UserDataSharingSettings.defaultSettings(),
      );

  SettingsState copyWith({
    bool? loading,
    bool? currentPasswordVisible,
    bool? newPasswordVisible,
    bool? confirmPasswordVisible,
    bool? shareEverything,
    UserDataSharingSettings? userDataSharingSettings,
  }) =>
      SettingsState(
        loading: loading ?? this.loading,
        currentPasswordVisible: currentPasswordVisible ?? this.currentPasswordVisible,
        newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
        confirmPasswordVisible: confirmPasswordVisible ?? this.confirmPasswordVisible,
        shareEverything: shareEverything ?? this.shareEverything,
        userDataSharingSettings: userDataSharingSettings ?? this.userDataSharingSettings,
      );
}
