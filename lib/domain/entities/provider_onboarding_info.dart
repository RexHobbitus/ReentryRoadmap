import 'package:reentry_roadmap/domain/entities/program_service_info.dart';
import 'package:reentry_roadmap/domain/entities/provider_details_info.dart';

import 'current_needs_info.dart';
import 'incarceration_info.dart';
import 'personal_info.dart';
import 'package:equatable/equatable.dart';

import 'service_provider_accessed.dart';

class ProviderOnboardingInfo extends Equatable {
  ProviderDetailsInfo? providerDetails;
  ProgramServiceInfo? programServiceInfo;
  ProviderOnboardingInfo({this.providerDetails, this.programServiceInfo});

  ProviderOnboardingInfo.fromJson(Map<String, dynamic> json) {
    providerDetails = json['providerDetails'] != null
        ? new ProviderDetailsInfo.fromJson(json['providerDetails'])
        : null;
    providerDetails = json['programServices'] != null
        ? new ProviderDetailsInfo.fromJson(json['programServices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providerDetails != null) {
      data['providerDetails'] = this.providerDetails!.toJson();
    }
    if (this.programServiceInfo != null) {
      data['programServices'] = this.programServiceInfo!.toJson();
    }

    return data;
  }

  ProviderOnboardingInfo copyWith(
      {ProviderDetailsInfo? providerDetails,
      ProgramServiceInfo? programServices}) {
    return ProviderOnboardingInfo(
        providerDetails: providerDetails ?? this.providerDetails,
        programServiceInfo: programServices ?? this.programServiceInfo);
  }

  @override
  // TODO: implement props
  @override
  List<Object?> get props => [providerDetails, programServiceInfo];
}
