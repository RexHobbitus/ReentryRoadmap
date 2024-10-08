

import 'package:reentry_roadmap/data/models/current_needs_info_json.dart';
import 'package:reentry_roadmap/data/models/incarcination_json.dart';
import 'package:reentry_roadmap/data/models/personal_info_json.dart';
import 'package:reentry_roadmap/domain/entities/onboarding_info.dart';

class OnboardingInfoJson {
  PersonalInfoJson? personalInfo;
  IncarcerationInfoJson? incarcerationInfo;
  CurrentNeedsInfoJson? currentNeedsInfo;

  OnboardingInfoJson({
    this.personalInfo,
    this.incarcerationInfo,
    this.currentNeedsInfo,
  });

  OnboardingInfoJson.fromJson(Map<String, dynamic> json) {
    personalInfo = json['personalInfo'] != null
        ? PersonalInfoJson.fromJson(json['personalInfo'])
        : null;
    incarcerationInfo = json['incarcerationInfo'] != null
        ? IncarcerationInfoJson.fromJson(json['incarcerationInfo'])
        : null;
    currentNeedsInfo = json['currentNeedsInfo'] != null
        ? CurrentNeedsInfoJson.fromJson(json['currentNeedsInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.personalInfo != null) {
      data['personalInfo'] = this.personalInfo!.toJson();
    }
    if (this.incarcerationInfo != null) {
      data['incarcerationInfo'] = this.incarcerationInfo!.toJson();
    }
    if (this.currentNeedsInfo != null) {
      data['currentNeedsInfo'] = this.currentNeedsInfo!.toJson();
    }
    return data;
  }

  OnboardingInfo toDomain() {
    return OnboardingInfo(
      personalInfo: personalInfo?.toDomain(),
      incarcerationInfo: incarcerationInfo?.toDomain(),
      currentNeedsInfo: currentNeedsInfo?.toDomain(),
    );
  }

  // CopyWith method
  OnboardingInfoJson copyWith({
    PersonalInfoJson? personalInfo,
    IncarcerationInfoJson? incarcerationInfo,
    CurrentNeedsInfoJson? currentNeedsInfo,
  }) {
    return OnboardingInfoJson(
      personalInfo: personalInfo ?? this.personalInfo,
      incarcerationInfo: incarcerationInfo ?? this.incarcerationInfo,
      currentNeedsInfo: currentNeedsInfo ?? this.currentNeedsInfo,
    );
  }
}
