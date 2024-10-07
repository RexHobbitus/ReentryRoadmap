import 'current_needs_info.dart';
import 'incarceration_info.dart';
import 'personal_info.dart';

class OnboardingInfo {
  PersonalInfo? personalInfo;
  IncarcerationInfo? incarcerationInfo;
  CurrentNeedsInfo? currentNeedsInfo;

  OnboardingInfo(
      {this.personalInfo,
        this.incarcerationInfo,
        this.currentNeedsInfo});

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
}
