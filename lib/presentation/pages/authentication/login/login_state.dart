import 'login_initial_params.dart';

class LoginState {
final bool loading;
const LoginState({required this.loading});

factory LoginState.initial() => const LoginState(loading: false);

LoginState copyWith({bool? loading}) => LoginState(loading: loading??this.loading);
}
