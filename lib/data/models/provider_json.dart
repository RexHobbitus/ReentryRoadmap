import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

import 'provider_onboarding_info_json.dart';

class ProviderJson {
  String? userId;
  String? email;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  ProviderOnboardingInfoJson? onboardingInfo;
  double? avgRating;
  int? totalReviews;
  ProviderJson(
      {this.userId,
        this.createdAt,
        this.updatedAt,
        this.onboardingInfo,
        this.email,
        this.avgRating,
        this.totalReviews,
      });

  ProviderJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onboardingInfo = json['providerOnboardingInfo'] != null
        ? new ProviderOnboardingInfoJson.fromJson(json['providerOnboardingInfo'])
        : null;
    avgRating=json['avgRating'];
    totalReviews=json['totalReviews'];
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
    data['avgRating'] = this.avgRating;
    data['totalReviews'] = this.totalReviews;
    return data;
  }

  Provider toDomain(){
    return Provider(
      userId: userId,
      email: email,
      createdAt: createdAt.toString(),
      updatedAt: updatedAt.toString(),
      onboardingInfo: onboardingInfo?.toDomain(),
      avgRating: avgRating??0,
      totalReviews: totalReviews??0,
    );
  }

}
