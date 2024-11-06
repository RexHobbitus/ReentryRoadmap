import 'package:equatable/equatable.dart';

class UserDataSharingSettings extends Equatable {
  final bool phoneNumber;
  final bool emailAddress;
  final bool location;
  final bool fullName;
  final bool dateOfBirth;
  final bool ethnicity;
  final bool gender;
  final bool veteranStatus;
  final bool idNumber;
  final bool timesIncarcerated;
  final bool incarcerationHistory;
  final bool latestOffense;
  final bool lengthOfLongestIncarceration;
  final bool lengthOfLatestIncarceration;
  final bool firstIncarcerationDate;
  final bool latestReleaseDate;
  final bool mostRecentTermServedIn;
  final bool programsAttendedWhileIncarcerated;

  const UserDataSharingSettings({
    required this.phoneNumber,
    required this.emailAddress,
    required this.location,
    required this.fullName,
    required this.dateOfBirth,
    required this.ethnicity,
    required this.gender,
    required this.veteranStatus,
    required this.idNumber,
    required this.timesIncarcerated,
    required this.incarcerationHistory,
    required this.latestOffense,
    required this.lengthOfLongestIncarceration,
    required this.lengthOfLatestIncarceration,
    required this.firstIncarcerationDate,
    required this.latestReleaseDate,
    required this.mostRecentTermServedIn,
    required this.programsAttendedWhileIncarcerated,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        emailAddress,
        location,
        fullName,
        dateOfBirth,
        ethnicity,
        gender,
        veteranStatus,
        idNumber,
        timesIncarcerated,
        incarcerationHistory,
        latestOffense,
        lengthOfLongestIncarceration,
        lengthOfLatestIncarceration,
        firstIncarcerationDate,
        latestReleaseDate,
        mostRecentTermServedIn,
        programsAttendedWhileIncarcerated,
      ];

  UserDataSharingSettings copyWith({
    bool? phoneNumber,
    bool? emailAddress,
    bool? location,
    bool? fullName,
    bool? dateOfBirth,
    bool? ethnicity,
    bool? gender,
    bool? veteranStatus,
    bool? idNumber,
    bool? timesIncarcerated,
    bool? incarcerationHistory,
    bool? latestOffense,
    bool? lengthOfLongestIncarceration,
    bool? lengthOfLatestIncarceration,
    bool? firstIncarcerationDate,
    bool? latestReleaseDate,
    bool? mostRecentTermServedIn,
    bool? programsAttendedWhileIncarcerated,
    bool? shareEverything,
  }) {
    return UserDataSharingSettings(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      location: location ?? this.location,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      ethnicity: ethnicity ?? this.ethnicity,
      gender: gender ?? this.gender,
      veteranStatus: veteranStatus ?? this.veteranStatus,
      idNumber: idNumber ?? this.idNumber,
      timesIncarcerated: timesIncarcerated ?? this.timesIncarcerated,
      incarcerationHistory: incarcerationHistory ?? this.incarcerationHistory,
      latestOffense: latestOffense ?? this.latestOffense,
      lengthOfLongestIncarceration: lengthOfLongestIncarceration ?? this.lengthOfLongestIncarceration,
      lengthOfLatestIncarceration: lengthOfLatestIncarceration ?? this.lengthOfLatestIncarceration,
      firstIncarcerationDate: firstIncarcerationDate ?? this.firstIncarcerationDate,
      latestReleaseDate: latestReleaseDate ?? this.latestReleaseDate,
      mostRecentTermServedIn: mostRecentTermServedIn ?? this.mostRecentTermServedIn,
      programsAttendedWhileIncarcerated: programsAttendedWhileIncarcerated ?? this.programsAttendedWhileIncarcerated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contactInformation': {
        'phoneNumber': phoneNumber,
        'emailAddress': emailAddress,
        'location': location,
      },
      'personalInformation': {
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'ethnicity': ethnicity,
        'gender': gender,
        'veteranStatus': veteranStatus,
      },
      'incarcerationDetails': {
        'idNumber': idNumber,
        'timesIncarcerated': timesIncarcerated,
        'incarcerationHistory': incarcerationHistory,
        'latestOffense': latestOffense,
        'lengthOfLongestIncarceration': lengthOfLongestIncarceration,
        'lengthOfLatestIncarceration': lengthOfLatestIncarceration,
        'firstIncarcerationDate': firstIncarcerationDate,
        'latestReleaseDate': latestReleaseDate,
        'mostRecentTermServedIn': mostRecentTermServedIn,
        'programsAttendedWhileIncarcerated': programsAttendedWhileIncarcerated,
      },
    };
  }

  factory UserDataSharingSettings.fromJson(Map<String, dynamic> json) {
    return UserDataSharingSettings(
      phoneNumber: json['contactInformation']['phoneNumber'] as bool? ?? false,
      emailAddress: json['contactInformation']['emailAddress'] as bool? ?? false,
      location: json['contactInformation']['location'] as bool? ?? false,
      fullName: json['personalInformation']['fullName'] as bool? ?? false,
      dateOfBirth: json['personalInformation']['dateOfBirth'] as bool? ?? false,
      ethnicity: json['personalInformation']['ethnicity'] as bool? ?? false,
      gender: json['personalInformation']['gender'] as bool? ?? false,
      veteranStatus: json['personalInformation']['veteranStatus'] as bool? ?? false,
      idNumber: json['incarcerationDetails']['idNumber'] as bool? ?? false,
      timesIncarcerated: json['incarcerationDetails']['timesIncarcerated'] as bool? ?? false,
      incarcerationHistory: json['incarcerationDetails']['incarcerationHistory'] as bool? ?? false,
      latestOffense: json['incarcerationDetails']['latestOffense'] as bool? ?? false,
      lengthOfLongestIncarceration: json['incarcerationDetails']['lengthOfLongestIncarceration'] as bool? ?? false,
      lengthOfLatestIncarceration: json['incarcerationDetails']['lengthOfLatestIncarceration'] as bool? ?? false,
      firstIncarcerationDate: json['incarcerationDetails']['firstIncarcerationDate'] as bool? ?? false,
      latestReleaseDate: json['incarcerationDetails']['latestReleaseDate'] as bool? ?? false,
      mostRecentTermServedIn: json['incarcerationDetails']['mostRecentTermServedIn'] as bool? ?? false,
      programsAttendedWhileIncarcerated:
          json['incarcerationDetails']['programsAttendedWhileIncarcerated'] as bool? ?? false,
    );
  }

  factory UserDataSharingSettings.defaultSettings() {
    return const UserDataSharingSettings(
      phoneNumber: true,
      emailAddress: true,
      location: true,
      fullName: true,
      dateOfBirth: true,
      ethnicity: true,
      gender: true,
      veteranStatus: true,
      idNumber: true,
      timesIncarcerated: true,
      incarcerationHistory: true,
      latestOffense: true,
      lengthOfLongestIncarceration: true,
      lengthOfLatestIncarceration: true,
      firstIncarcerationDate: true,
      latestReleaseDate: true,
      mostRecentTermServedIn: true,
      programsAttendedWhileIncarcerated: true,
    );
  }

  factory UserDataSharingSettings.defaultOfftSettings() {
    return const UserDataSharingSettings(
      phoneNumber: false,
      emailAddress: false,
      location: false,
      fullName: false,
      dateOfBirth: false,
      ethnicity: false,
      gender: false,
      veteranStatus: false,
      idNumber: false,
      timesIncarcerated: false,
      incarcerationHistory: false,
      latestOffense: false,
      lengthOfLongestIncarceration: false,
      lengthOfLatestIncarceration: false,
      firstIncarcerationDate: false,
      latestReleaseDate: false,
      mostRecentTermServedIn: false,
      programsAttendedWhileIncarcerated: false,
    );
  }
  bool get shareEverything {
    return phoneNumber &&
        emailAddress &&
        location &&
        fullName &&
        dateOfBirth &&
        ethnicity &&
        gender &&
        veteranStatus &&
        idNumber &&
        timesIncarcerated &&
        incarcerationHistory &&
        latestOffense &&
        lengthOfLongestIncarceration &&
        lengthOfLatestIncarceration &&
        firstIncarcerationDate &&
        latestReleaseDate &&
        mostRecentTermServedIn &&
        programsAttendedWhileIncarcerated;
  }
}
