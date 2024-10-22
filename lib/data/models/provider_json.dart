import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

import 'provider_onboarding_info_json.dart';

class ProviderJson {
  String? userId;
  String? email;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  ProviderOnboardingInfoJson? onboardingInfo;
  ProviderJson(
      {this.userId,
        this.createdAt,
        this.updatedAt,
        this.onboardingInfo,
        this.email});

  ProviderJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onboardingInfo = json['onboardingInfo'] != null
        ? new ProviderOnboardingInfoJson.fromJson(json['onboardingInfo'])
        : null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.onboardingInfo != null) {
      data['onboardingInfo'] = this.onboardingInfo!.toJson();
    }
    return data;
  }

  Provider toDomain(){
    return Provider(
      userId: userId,
      email: email,
      createdAt: createdAt.toString(),
      updatedAt: updatedAt.toString(),
      onboardingInfo: onboardingInfo?.toDomain(),
    );
  }

}
