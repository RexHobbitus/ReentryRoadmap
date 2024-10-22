import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';

import 'package:equatable/equatable.dart';

class Provider extends Equatable {
  String? userId;
  String? email;
  String? createdAt;
  String? updatedAt;
  ProviderOnboardingInfo? onboardingInfo;
  Provider(
      {this.userId,
        this.createdAt,
        this.updatedAt,
        this.onboardingInfo,
        this.email});

  Provider.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onboardingInfo = json['onboardingInfo'] != null
        ? new ProviderOnboardingInfo.fromJson(json['onboardingInfo'])
        : null;
  }

  Provider.empty() {

  }

  bool get isLoggedIn => userId!=null;

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

  Provider copyWith({
    String? userId,
    String? email,
    String? createdAt,
    String? updatedAt,
    ProviderOnboardingInfo? onboardingInfo,
  }) {
    return Provider(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      onboardingInfo: onboardingInfo ?? this.onboardingInfo,
    );
  }
  @override
  List<Object?> get props => [
    userId,
    email,
    createdAt,
    updatedAt,
    onboardingInfo,
  ];

}
