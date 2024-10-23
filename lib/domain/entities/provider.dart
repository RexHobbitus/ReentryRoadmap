import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';

import 'package:equatable/equatable.dart';

class Provider extends Equatable {
  String? userId;
  String? email;
  String? createdAt;
  String? updatedAt;
  ProviderOnboardingInfo? onboardingInfo;
  double? avgRating;
  int? totalReviews;

  Provider({
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.onboardingInfo,
    this.email,
    this.avgRating,
    this.totalReviews,


  });

  Provider.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onboardingInfo = json['onboardingInfo'] != null
        ? new ProviderOnboardingInfo.fromJson(json['onboardingInfo'])
        : null;
    avgRating = json['avgRating'];
    totalReviews = json['totalReviews'];
  }

  Provider.shimmer() {
    email = "Testing";
    onboardingInfo = ProviderOnboardingInfo.shimmer();
    avgRating = 5.0;
    totalReviews = 10;
  }

  bool get isLoggedIn => userId != null;

  String get completeAddress =>
      "${onboardingInfo?.providerDetails?.street} ${onboardingInfo
          ?.providerDetails?.city} ${onboardingInfo?.providerDetails?.country}";

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

  Provider copyWith({
    String? userId,
    String? email,
    String? createdAt,
    String? updatedAt,
    ProviderOnboardingInfo? onboardingInfo,
    double? avgRating,
    int? totalReviews,
  }) {
    return Provider(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      onboardingInfo: onboardingInfo ?? this.onboardingInfo,
      avgRating: avgRating ?? this.avgRating,
      totalReviews: totalReviews ?? this.totalReviews,

    );
  }

  @override
  List<Object?> get props =>
      [
        userId,
        email,
        createdAt,
        updatedAt,
        onboardingInfo,
        avgRating,
        totalReviews,
      ];
}
