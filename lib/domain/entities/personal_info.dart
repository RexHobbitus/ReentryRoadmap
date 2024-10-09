import 'package:equatable/equatable.dart';

class PersonalInfo extends Equatable {
  String? firstName;
  String? middleName;
  String? lastName;

  DateTime? dateOfBirth;
  String? ethnicity;
  String? gender;
  String? veteranStatus;
  String? street;
  String? city;
  String? state;
  String? phoneNumber;

  PersonalInfo({
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.ethnicity,
    this.gender,
    this.veteranStatus,
    this.street,
    this.city,
    this.state,
    this.phoneNumber,
  });

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    ethnicity = json['ethnicity'];
    gender = json['gender'];
    veteranStatus = json['veteranStatus'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['ethnicity'] = this.ethnicity;
    data['gender'] = this.gender;
    data['veteranStatus'] = this.veteranStatus;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }

  PersonalInfo copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    DateTime? dateOfBirth,
    String? ethnicity,
    String? gender,
    String? veteranStatus,
    String? street,
    String? city,
    String? state,
    String? phoneNumber,
  }) {
    return PersonalInfo(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      ethnicity: ethnicity ?? this.ethnicity,
      gender: gender ?? this.gender,
      veteranStatus: veteranStatus ?? this.veteranStatus,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        dateOfBirth,
        ethnicity,
        gender,
        veteranStatus,
        street,
        city,
        state,
        phoneNumber,
      ];
}
