/*
1) THIS MODEL CLASS IS ACCORDING TO DATA COMING FROM SERVER SIDE, EITHER FIREBASE OR RESTAPI JSON
2) WE WILL FIRST CONVERT OUR JSON COMING FROM SERVER TO THIS MODEL_JSON
3) THEN THIS MODEL_JSON WILL BE CONVERTED TO MODEL(entity) BY USING toDomain() method.
4) THAT MODEL WILL BE USED BY OUR UI

Steps
var userData => {"id:"123,"name":"test","email:"test@email.com",} => JSON got from server/db
var appUserJson => AppUserJson.fromJson(userData); => Convert server json data to exact same model class
var appUser=appUserJson.toDomain() => Then convert server response data model class to entity class=> This entity model will be used by UI
 */


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/models/onboarding_info_json.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';

class AppUserJson {
  String? userId;
  String? email;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  OnboardingInfoJson? onboardingInfo;

  AppUserJson({
    this.userId,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.onboardingInfo,
  });

  AppUserJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onboardingInfo = json['onboardingInfo'] != null
        ? OnboardingInfoJson.fromJson(json['onboardingInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.onboardingInfo != null) {
      data['onboardingInfo'] = this.onboardingInfo!.toJson();
    }
    return data;
  }

  // Convert to Domain Model
  AppUser toDomain() {
    return AppUser(
      userId: userId,
      email: email,
      createdAt: createdAt?.toDate().toString(),
      updatedAt: updatedAt?.toDate().toString(),
      onboardingInfo: onboardingInfo?.toDomain(),
    );
  }
  //
  // // CopyWith method
  // AppUserJson copyWith({
  //   String? userId,
  //   String? email,
  //   String? createdAt,
  //   String? updatedAt,
  //   OnboardingInfoJson? onboardingInfo,
  // }) {
  //   return AppUserJson(
  //     userId: userId ?? this.userId,
  //     email: email ?? this.email,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //     onboardingInfo: onboardingInfo ?? this.onboardingInfo,
  //   );
  // }
}
