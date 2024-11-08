import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';

class ProviderDetailState {
  final bool loading;
  final bool loadingReviews;
  final int selectedMenuIndex;
  final Provider provider;
  final List<ProviderReview> reviews;
  const ProviderDetailState({
    required this.loading,
    required this.loadingReviews,
    required this.selectedMenuIndex,
    required this.provider,
    required this.reviews,
  });

  factory ProviderDetailState.initial() => ProviderDetailState(
        loading: false,
        loadingReviews: false,
        selectedMenuIndex: 0,
        provider: Provider.shimmer(),
        reviews: [],
      );

  ProviderDetailState copyWith({
    bool? loading,
    bool? loadingReviews,
    int? selectedMenuIndex,
    Provider? provider,
    List<ProviderReview>? reviews,
  }) =>
      ProviderDetailState(
        loading: loading ?? this.loading,
        loadingReviews: loadingReviews ?? this.loadingReviews,
        selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
        provider: provider ?? this.provider,
        reviews: reviews ?? this.reviews,
      );
}
