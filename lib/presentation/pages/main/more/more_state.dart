import 'more_initial_params.dart';

class MoreState {
final bool loading;
const MoreState({required this.loading});

factory MoreState.initial() => const MoreState(loading: false);

MoreState copyWith({bool? loading}) => MoreState(loading: loading??this.loading);
}
