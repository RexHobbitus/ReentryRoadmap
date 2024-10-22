import 'package:reentry_roadmap/data/models/general_service_json.dart';
import 'package:reentry_roadmap/data/models/program_json.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';

import 'provider_details_info_json.dart';

class ProviderOnboardingInfoJson  {
  ProviderDetailsInfoJson? providerDetails;
  List<ProgramJson>? programs;
  GeneralServiceJson? generalService;
  ProviderOnboardingInfoJson(
      {this.providerDetails, this.programs, this.generalService});

  ProviderOnboardingInfoJson.fromJson(Map<String, dynamic> json) {
    providerDetails = json['providerDetails'] != null
        ? new ProviderDetailsInfoJson.fromJson(json['providerDetails'])
        : null;
    generalService = json['generalService'] != null
        ? new GeneralServiceJson.fromJson(json['generalService'])
        : null;
    if (json['programs'] != null) {
      programs = <ProgramJson>[];
      json['programs'].forEach((v) {
        programs!.add(new ProgramJson.fromJson(v));
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

  ProviderOnboardingInfo toDomain(){
    return ProviderOnboardingInfo(
      providerDetails: providerDetails?.toDomain(),
      generalService: generalService?.toDomain(),
      programs: programs?.map((program)=>program.toDomain()).toList()??[]
    );
  }

}
