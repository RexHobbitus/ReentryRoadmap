class ProviderOnboardingState {
  final bool loading;
  final int providerOnboardingSectionIndex;
  final List<dynamic> providerLocationImages;

  const ProviderOnboardingState({
    required this.loading,
    this.providerOnboardingSectionIndex = 0,
    required this.providerLocationImages,
  });

  factory ProviderOnboardingState.initial() =>
      const ProviderOnboardingState(loading: false, providerLocationImages: []);

  ProviderOnboardingState copyWith({
    bool? loading,
    int? providerOnboardingSectionIndex,
    List<dynamic>? providerLocationImages,
  }) =>
      ProviderOnboardingState(
        loading: loading ?? this.loading,
        providerOnboardingSectionIndex: providerOnboardingSectionIndex ??
            this.providerOnboardingSectionIndex,
        providerLocationImages:
            providerLocationImages ?? this.providerLocationImages,
      );
}
