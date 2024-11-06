import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';

import 'package:equatable/equatable.dart';

import 'rating_count.dart';

class Provider extends Equatable {
  String? userId;
  String? email;
  String? createdAt;
  String? updatedAt;
  ProviderOnboardingInfo? onboardingInfo;
  double? avgRating;
  int? totalReviews;
  RatingCount? ratingCount;
  String? orgId;
  Provider({
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.onboardingInfo,
    this.email,
    this.avgRating,
    this.totalReviews,
    this.ratingCount,
    this.orgId,
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
    ratingCount = json['ratingCount'] != null
        ? new RatingCount.fromJson(json['ratingCount'])
        : null;
    orgId = json['orgId'] ?? "";
  }

  Provider.shimmer() {
    email = "Testing";
    onboardingInfo = ProviderOnboardingInfo.shimmer();
    avgRating = 5.0;
    totalReviews = 10;
    ratingCount=RatingCount.shimmer();
  }

  bool get isLoggedIn => userId != null;

  String get completeAddress =>
      "${onboardingInfo?.providerDetails?.street} ${onboardingInfo
          ?.providerDetails?.city} ${onboardingInfo?.providerDetails?.country}";

  List<String> getAllCategories() {
    // Get category titles from generalService
    List<String> generalCategoryTitles =onboardingInfo?.generalService?.serviceCategories
        ?.map((category) => category.title.toString())
        .toList() ?? [];

    // Get category titles from each program
    List<String> programCategoryTitles = onboardingInfo?.programs
        ?.expand((program) => program.programCategories!.map((category) => category.title.toString()))
        .cast<String>()
        .toList() ?? [];

    // Combine both lists
    List<String> allCategoryTitles = [...generalCategoryTitles, ...programCategoryTitles];

    return allCategoryTitles.toSet().toList();
  }

  List<String> getAllFeatures() {
    // Get category titles from generalService
    List<String> generalFeatures =onboardingInfo?.generalService?.features
        ?.map((value) => value.toString())
        .toList() ?? [];

    // Get category titles from each program
    List<String> programFeatures = onboardingInfo?.programs
        ?.expand((program) => program.features!.map((feature) => feature.toString()))
        .cast<String>()
        .toList() ?? [];

    // Combine both lists
    List<String> allFeatures = [...generalFeatures, ...programFeatures];

    return allFeatures.toSet().toList();
  }

  List<String> getAllEligibilityCriteria() {
    // Get category titles from generalService
    List<String> generalCriteria =onboardingInfo?.generalService?.eligibilityCriteria
        ?.map((value) => value.toString())
        .toList() ?? [];

    // Get category titles from each program
    List<String> programCriteria = onboardingInfo?.programs
        ?.expand((program) => program.eligibilityCriteria!.map((value) => value.toString()))
        .cast<String>()
        .toList() ?? [];

    // Combine both lists
    List<String> allCriteria = [...generalCriteria, ...programCriteria];

    return allCriteria.toSet().toList();
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
    data['orgId'] = this.orgId;
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
    String? orgId,
  }) {
    return Provider(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      onboardingInfo: onboardingInfo ?? this.onboardingInfo,
      avgRating: avgRating ?? this.avgRating,
      totalReviews: totalReviews ?? this.totalReviews,
      orgId: orgId ?? this.orgId,

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
        orgId,
      ];
}
