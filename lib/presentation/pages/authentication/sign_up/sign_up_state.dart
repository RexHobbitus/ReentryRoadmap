import 'sign_up_initial_params.dart';

class SignUpState {
final bool loading;
const SignUpState({required this.loading});

factory SignUpState.initial() => const SignUpState(loading: false);

SignUpState copyWith({bool? loading}) => SignUpState(loading: loading??this.loading);
}
