import 'welcome_initial_params.dart';

class WelcomeState {
final bool loading;
const WelcomeState({required this.loading});

factory WelcomeState.initial() => const WelcomeState(loading: false);

WelcomeState copyWith({bool? loading}) => WelcomeState(loading: loading??this.loading);
}
