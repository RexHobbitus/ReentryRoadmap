import 'onboarding_info.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  String? userId;
  String? email;
  String? createdAt;
  String? updatedAt;
  OnboardingInfo? onboardingInfo;
  bool? isVerified;

  AppUser({
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.onboardingInfo,
    this.email,
    this.isVerified,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onboardingInfo = json['onboardingInfo'] != null
        ? new OnboardingInfo.fromJson(json['onboardingInfo'])
        : null;
    isVerified = json['isVerified'];
  }

  AppUser.empty() {

  }

  bool get isLoggedIn => userId != null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.onboardingInfo != null) {
      data['onboardingInfo'] = this.onboardingInfo!.toJson();
    }
    data['isVerified'] = isVerified;
    return data;
  }

  AppUser copyWith({
    String? userId,
    String? email,
    String? createdAt,
    String? updatedAt,
    OnboardingInfo? onboardingInfo,
    bool? isVerified,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      onboardingInfo: onboardingInfo ?? this.onboardingInfo,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        createdAt,
        updatedAt,
        onboardingInfo,
        isVerified,
      ];
}
