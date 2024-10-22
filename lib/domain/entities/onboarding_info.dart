import 'current_needs_info.dart';
import 'incarceration_info.dart';
import 'personal_info.dart';
import 'package:equatable/equatable.dart';

import 'service_provider_accessed.dart';

class OnboardingInfo extends Equatable {
  PersonalInfo? personalInfo;
  IncarcerationInfo? incarcerationInfo;
  CurrentNeedsInfo? currentNeedsInfo;
  ServiceProviderAccessed? serviceProviderAccessed;

  OnboardingInfo({
    this.personalInfo,
    this.incarcerationInfo,
    this.currentNeedsInfo,
    this.serviceProviderAccessed,
  });

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
    serviceProviderAccessed = json['serviceProviderAccessed'] != null
        ? new ServiceProviderAccessed.fromJson(json['serviceProviderAccessed'])
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
    if (this.serviceProviderAccessed != null) {
      data['serviceProviderAccessed'] = this.serviceProviderAccessed!.toJson();
    }

    return data;
  }

  OnboardingInfo copyWith({
    PersonalInfo? personalInfo,
    IncarcerationInfo? incarcerationInfo,
    CurrentNeedsInfo? currentNeedsInfo,
    ServiceProviderAccessed? serviceProviderAccessed,
  }) {
    return OnboardingInfo(
      personalInfo: personalInfo ?? this.personalInfo,
      incarcerationInfo: incarcerationInfo ?? this.incarcerationInfo,
      currentNeedsInfo: currentNeedsInfo ?? this.currentNeedsInfo,
      serviceProviderAccessed:
          serviceProviderAccessed ?? this.serviceProviderAccessed,
    );
  }

  @override
  // TODO: implement props
  @override
  List<Object?> get props => [
        personalInfo,
        incarcerationInfo,
        currentNeedsInfo,
        serviceProviderAccessed,
      ];
}
