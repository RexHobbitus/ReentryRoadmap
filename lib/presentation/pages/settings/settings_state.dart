import 'settings_initial_params.dart';

class SettingsState {
  final bool loading;
  const SettingsState({required this.loading});

  factory SettingsState.initial() => const SettingsState(loading: false);

  SettingsState copyWith({bool? loading}) => SettingsState(loading: loading ?? this.loading);
}
