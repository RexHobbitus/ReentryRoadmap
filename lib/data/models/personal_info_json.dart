import '../../domain/entities/personal_info.dart';

class PersonalInfoJson {
  String? fullName;
  String? dateOfBirth;
  String? ethnicity;
  String? gender;
  String? veteranStatus;

  PersonalInfoJson({
    this.fullName,
    this.dateOfBirth,
    this.ethnicity,
    this.gender,
    this.veteranStatus,
  });

  PersonalInfoJson.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    dateOfBirth = json['dateOfBirth'];
    ethnicity = json['ethnicity'];
    gender = json['gender'];
    veteranStatus = json['veteranStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullName'] = this.fullName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['ethnicity'] = this.ethnicity;
    data['gender'] = this.gender;
    data['veteranStatus'] = this.veteranStatus;
    return data;
  }

  PersonalInfo toDomain() {
    return PersonalInfo(
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      ethnicity: ethnicity,
      gender: gender,
      veteranStatus: veteranStatus,
    );
  }

  PersonalInfoJson copyWith({
    String? fullName,
    String? dateOfBirth,
    String? ethnicity,
    String? gender,
    String? veteranStatus,
  }) {
    return PersonalInfoJson(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      ethnicity: ethnicity ?? this.ethnicity,
      gender: gender ?? this.gender,
      veteranStatus: veteranStatus ?? this.veteranStatus,
    );
  }
}
