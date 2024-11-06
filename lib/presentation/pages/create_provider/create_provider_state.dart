class CreateProviderState {
  final bool loading;

  const CreateProviderState({
    required this.loading,
  });

  factory CreateProviderState.initial() =>
      const CreateProviderState(loading: false);

  CreateProviderState copyWith({
    bool? loading,
  }) =>
      CreateProviderState(loading: loading ?? this.loading);
}
