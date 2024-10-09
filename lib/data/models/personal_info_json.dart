import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/personal_info.dart';

class PersonalInfoJson {
  String? firstName;
  String? middleName;
  String? lastName;

  Timestamp? dateOfBirth;
  String? ethnicity;
  String? gender;
  String? veteranStatus;

  String? street;
  String? city;
  String? state;
  String? phoneNumber;

  PersonalInfoJson({
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

  PersonalInfoJson.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
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

  PersonalInfo toDomain() {
    return PersonalInfo(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      dateOfBirth: dateOfBirth?.toDate(),
      ethnicity: ethnicity,
      gender: gender,
      veteranStatus: veteranStatus,
      street: street,
      city: city,
      state: state,
      phoneNumber: phoneNumber,
    );
  }

  PersonalInfoJson copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    Timestamp? dateOfBirth,
    String? ethnicity,
    String? gender,
    String? veteranStatus,
    String? street,
    String? city,
    String? state,
    String? phoneNumber,
  }) {
    return PersonalInfoJson(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
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
}
