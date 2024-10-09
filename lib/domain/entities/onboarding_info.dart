import 'package:reentry_roadmap/domain/entities/app_provider.dart';

import 'current_needs_info.dart';
import 'incarceration_info.dart';
import 'personal_info.dart';
import 'package:equatable/equatable.dart';

class OnboardingInfo extends Equatable {
  PersonalInfo? personalInfo;
  IncarcerationInfo? incarcerationInfo;
  CurrentNeedsInfo? currentNeedsInfo;
  AppProvider? appProvider;

  OnboardingInfo(
      {this.personalInfo, this.incarcerationInfo, this.currentNeedsInfo});

  OnboardingInfo.fromJson(Map<String, dynamic> json) {
    personalInfo = json['personalInfo'] != null
        ? new PersonalInfo.fromJson(json['personalInfo'])
        : null;
    incarcerationInfo = json['incarcerationInfo'] != null
        ? new IncarcerationInfo.fromJson(json['incarcerationInfo'])
        : null;
    currentNeedsInfo = json['currentNeedsInfo'] != null
        ? new CurrentNeedsInfo.fromJson(json['currentNeedsInfo'])
        : null;
    appProvider = json['appProviderInfo'] != null
        ? new AppProvider.fromJson(json['appProviderInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  OnboardingInfo copyWith({
    PersonalInfo? personalInfo,
    IncarcerationInfo? incarcerationInfo,
    CurrentNeedsInfo? currentNeedsInfo,
  }) {
    return OnboardingInfo(
      personalInfo: personalInfo ?? this.personalInfo,
      incarcerationInfo: incarcerationInfo ?? this.incarcerationInfo,
      currentNeedsInfo: currentNeedsInfo ?? this.currentNeedsInfo,
    );
  }

  @override
  List<Object?> get props => [
        personalInfo,
        incarcerationInfo,
        currentNeedsInfo,
      ];
}
