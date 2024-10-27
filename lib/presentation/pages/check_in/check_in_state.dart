import 'package:reentry_roadmap/domain/entities/app_user.dart';

class CheckInState {
  final bool loading;
  final int checkInSectionIndex;
  final AppUser appUser;

  const CheckInState(
      {required this.loading,
      this.checkInSectionIndex = 0,
      required this.appUser});

  factory CheckInState.initial() => CheckInState(
        loading: false,
        appUser: AppUser.empty(),
      );

  CheckInState copyWith(
          {bool? loading, int? checkInSectionIndex, AppUser? appUser}) =>
      CheckInState(
        loading: loading ?? this.loading,
        checkInSectionIndex: checkInSectionIndex ?? this.checkInSectionIndex,
        appUser: appUser ?? this.appUser,
      );
}
