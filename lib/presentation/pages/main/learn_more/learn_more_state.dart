import 'learn_more_initial_params.dart';

class LearnMoreState {
final bool loading;
const LearnMoreState({required this.loading});

factory LearnMoreState.initial() => const LearnMoreState(loading: false);

LearnMoreState copyWith({bool? loading}) => LearnMoreState(loading: loading??this.loading);
}
