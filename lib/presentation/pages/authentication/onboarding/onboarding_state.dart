class OnboardingState {
  final bool loading;
  final int onboardingSectionIndex;

  const OnboardingState(
      {required this.loading, this.onboardingSectionIndex = 0});

  factory OnboardingState.initial() => const OnboardingState(loading: false);

  OnboardingState copyWith({bool? loading, int? onboardingSectionIndex}) =>
      OnboardingState(
        loading: loading ?? this.loading,
        onboardingSectionIndex:
            onboardingSectionIndex ?? this.onboardingSectionIndex,
      );
}
