class ProfileState {
  final bool loading;
  final bool edit;
  const ProfileState({required this.loading, required this.edit});

  factory ProfileState.initial() => const ProfileState(loading: false, edit: false);

  ProfileState copyWith({bool? loading, bool? edit}) =>
      ProfileState(loading: loading ?? this.loading, edit: edit ?? this.edit);
}
