import 'review_initial_params.dart';

class ReviewState {
final bool loading;
const ReviewState({required this.loading});

factory ReviewState.initial() => const ReviewState(loading: false);

ReviewState copyWith({bool? loading}) => ReviewState(loading: loading??this.loading);
}
