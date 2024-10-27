class CheckInState {
  final bool loading;
  final int checkInSectionIndex;

  const CheckInState({required this.loading, this.checkInSectionIndex = 0});

  factory CheckInState.initial() => const CheckInState(loading: false);

  CheckInState copyWith({bool? loading, int? checkInSectionIndex}) =>
      CheckInState(
        loading: loading ?? this.loading,
        checkInSectionIndex: checkInSectionIndex ?? this.checkInSectionIndex,
      );
}
