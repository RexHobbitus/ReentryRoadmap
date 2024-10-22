import 'package:reentry_roadmap/domain/entities/provider_details_info.dart';

import 'package:equatable/equatable.dart';
import 'general_service.dart';
import 'program.dart';

class ProviderOnboardingInfo extends Equatable {
  ProviderDetailsInfo? providerDetails;
  GeneralService? generalService;
  List<Program>? programs;

  ProviderOnboardingInfo(
      {this.providerDetails, this.programs, this.generalService});

  ProviderOnboardingInfo.fromJson(Map<String, dynamic> json) {
    providerDetails = json['providerDetails'] != null
        ? new ProviderDetailsInfo.fromJson(json['providerDetails'])
        : null;
    generalService = json['generalService'] != null
        ? new GeneralService.fromJson(json['generalService'])
        : null;
    if (json['programs'] != null) {
      programs = <Program>[];
      json['programs'].forEach((v) {
        programs!.add(new Program.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providerDetails != null) {
      data['providerDetails'] = this.providerDetails!.toJson();
    }
    if (this.generalService != null) {
      data['generalService'] = this.generalService!.toJson();
    }
    if (this.programs != null) {
      data['programs'] = this.programs!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  ProviderOnboardingInfo copyWith({
    ProviderDetailsInfo? providerDetails,
    GeneralService? generalService,
    List<Program>? programs,
  }) {
    return ProviderOnboardingInfo(
      providerDetails: providerDetails ?? this.providerDetails,
      generalService: generalService ?? this.generalService,
      programs: programs ?? this.programs,
    );
  }

  @override
  // TODO: implement props
  @override
  List<Object?> get props => [
        providerDetails,
        generalService,
        programs,
      ];
}
