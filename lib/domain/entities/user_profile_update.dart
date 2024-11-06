import 'package:equatable/equatable.dart';

import 'current_needs_info.dart';
import 'personal_info.dart';

class UserProfileUpdateInfo extends Equatable {
  final PersonalInfo? personalInfo;
  final CurrentNeedsInfo? currentNeedsInfo;

  const UserProfileUpdateInfo({
    this.personalInfo,
    this.currentNeedsInfo,
  });

  @override
  List<Object?> get props => [personalInfo, currentNeedsInfo];
}
