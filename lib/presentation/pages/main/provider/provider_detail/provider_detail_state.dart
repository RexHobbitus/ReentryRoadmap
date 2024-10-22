import 'package:reentry_roadmap/domain/entities/provider.dart';

import 'provider_detail_initial_params.dart';

class ProviderDetailState {
  final bool loading;
  final int selectedMenuIndex;
  final Provider provider;

  const ProviderDetailState({
    required this.loading,
    required this.selectedMenuIndex,
    required this.provider,
  });

  factory ProviderDetailState.initial() => ProviderDetailState(
        loading: false,
        selectedMenuIndex: 0,
        provider: Provider.shimmer(),
      );

  ProviderDetailState copyWith(
          {bool? loading, int? selectedMenuIndex, Provider? provider}) =>
      ProviderDetailState(
        loading: loading ?? this.loading,
        selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
        provider: provider ?? this.provider,
      );
}
