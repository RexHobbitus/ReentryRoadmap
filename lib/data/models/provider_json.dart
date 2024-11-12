import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

import 'provider_onboarding_info_json.dart';
import 'rating_count_json.dart';

class ProviderJson {
  String? userId;
  String? email;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  ProviderOnboardingInfoJson? providerOnboardingInfo;
  double? avgRating;
  int? totalReviews;
  RatingCountJson? ratingCount;

  ProviderJson({
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.providerOnboardingInfo,
    this.email,
    this.avgRating,
    this.totalReviews,
    this.ratingCount,

  });

  ProviderJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    providerOnboardingInfo = json['providerOnboardingInfo'] != null
        ? new ProviderOnboardingInfoJson.fromJson(
            json['providerOnboardingInfo'])
        : null;
    avgRating = json['avgRating'];
    totalReviews = json['totalReviews'];
    ratingCount = json['ratingCount'] != null
        ? new RatingCountJson.fromJson(json['ratingCount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.providerOnboardingInfo != null) {
      data['providerOnboardingInfo'] = this.providerOnboardingInfo!.toJson();
    }
    data['avgRating'] = this.avgRating;
    data['totalReviews'] = this.totalReviews;
    if (this.ratingCount != null) {
      data['ratingCount'] = this.ratingCount!.toJson();
    }
    return data;
  }

  Provider toDomain() {
    return Provider(
      userId: userId,
      email: email,
      createdAt: createdAt.toString(),
      updatedAt: updatedAt.toString(),
      onboardingInfo: providerOnboardingInfo?.toDomain(),
      avgRating: avgRating ?? 0,
      totalReviews: totalReviews ?? 0,
      ratingCount: ratingCount?.toDomain()
    );
  }
}
