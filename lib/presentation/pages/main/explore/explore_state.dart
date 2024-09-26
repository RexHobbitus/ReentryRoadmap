import 'explore_initial_params.dart';

class ExploreState {
final bool loading;
const ExploreState({required this.loading});

factory ExploreState.initial() => const ExploreState(loading: false);

ExploreState copyWith({bool? loading}) => ExploreState(loading: loading??this.loading);
}
