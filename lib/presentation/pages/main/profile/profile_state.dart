import 'profile_initial_params.dart';

class ProfileState {
final bool loading;
const ProfileState({required this.loading});

factory ProfileState.initial() => const ProfileState(loading: false);

ProfileState copyWith({bool? loading}) => ProfileState(loading: loading??this.loading);
}
