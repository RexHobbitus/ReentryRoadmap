import '../../../../../data/models/review_parameter.dart';

class UserReviewsState {
  final bool loading;
  final List<ReviewParameter>? reviews;
  final String? errorMessage;

  const UserReviewsState({
    required this.loading,
    this.reviews,
    this.errorMessage,
  });

  // Initial state when the screen first loads
  factory UserReviewsState.initial() => const UserReviewsState(
    loading: false,
    reviews: null,
    errorMessage: null,
  );

  // State when data is being loaded
  factory UserReviewsState.loading() => const UserReviewsState(
    loading: true,
    reviews: null,
    errorMessage: null,
  );

  // State when data is successfully loaded
  factory UserReviewsState.loaded(List<ReviewParameter> reviews) =>
      UserReviewsState(
        loading: false,
        reviews: reviews,
        errorMessage: null,
      );

  // State when there is an error
  factory UserReviewsState.error(String errorMessage) => UserReviewsState(
    loading: false,
    reviews: null,
    errorMessage: errorMessage,
  );

  // Helper function to update the current state
  UserReviewsState copyWith({
    bool? loading,
    List<ReviewParameter>? reviews,
    String? errorMessage,
  }) {
    return UserReviewsState(
      loading: loading ?? this.loading,
      reviews: reviews ?? this.reviews,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
