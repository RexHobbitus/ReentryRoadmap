class ProviderOnboardingState {
  final bool loading;
  final int providerOnboardingSectionIndex;

  const ProviderOnboardingState(
      {required this.loading, this.providerOnboardingSectionIndex = 0});

  factory ProviderOnboardingState.initial() => const ProviderOnboardingState(loading: false);

  ProviderOnboardingState copyWith({bool? loading, int? providerOnboardingSectionIndex}) =>
      ProviderOnboardingState(
        loading: loading ?? this.loading,
        providerOnboardingSectionIndex:
            providerOnboardingSectionIndex ?? this.providerOnboardingSectionIndex,
      );
}
