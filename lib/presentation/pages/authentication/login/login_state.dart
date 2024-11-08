import 'login_initial_params.dart';

class LoginState {
  final bool loading;
  final bool hidePassword;

  const LoginState({
    required this.loading,
    required this.hidePassword,
  });

  factory LoginState.initial() =>
      const LoginState(loading: false, hidePassword: true);

  LoginState copyWith({
    bool? loading,
    bool? hidePassword,
  }) =>
      LoginState(
        loading: loading ?? this.loading,
        hidePassword: hidePassword ?? this.hidePassword,
      );
}
