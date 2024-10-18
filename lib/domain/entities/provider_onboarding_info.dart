import 'package:reentry_roadmap/domain/entities/provider_details.dart';

import 'current_needs_info.dart';
import 'incarceration_info.dart';
import 'personal_info.dart';
import 'package:equatable/equatable.dart';

import 'service_provider_accessed.dart';

class ProviderOnboardingInfo extends Equatable {
  ProviderDetails? providerDetails;

  ProviderOnboardingInfo({
    this.providerDetails,
  });

  ProviderOnboardingInfo.fromJson(Map<String, dynamic> json) {
    providerDetails = json['providerDetails'] != null
        ? new ProviderDetails.fromJson(json['providerDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providerDetails != null) {
      data['providerDetails'] = this.providerDetails!.toJson();
    }

    return data;
  }

  ProviderOnboardingInfo copyWith({
    ProviderDetails? providerDetails,
  }) {
    return ProviderOnboardingInfo(
      providerDetails: providerDetails ?? this.providerDetails,
    );
  }

  @override
  // TODO: implement props
  @override
  List<Object?> get props => [
        providerDetails,
      ];
}
