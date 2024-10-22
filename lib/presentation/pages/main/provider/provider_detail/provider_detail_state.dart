import 'provider_detail_initial_params.dart';

class ProviderDetailState {
  final bool loading;
  final int selectedMenuIndex;

  const ProviderDetailState({
    required this.loading,
    required this.selectedMenuIndex,
  });

  factory ProviderDetailState.initial() => const ProviderDetailState(
        loading: false,
        selectedMenuIndex: 0,
      );

  ProviderDetailState copyWith({bool? loading, int? selectedMenuIndex}) =>
      ProviderDetailState(
        loading: loading ?? this.loading,
        selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
      );
}
