
import 'package:reentry_roadmap/domain/entities/general_service_info.dart';

class GeneralServiceInfoJson {
  List<String>? generalServicesCategories;
  List<String>? generalServicesSubCategories;
  List<String>? generalServicesFeatures;
  List<String>? generalServicesEligibility;

  GeneralServiceInfoJson({
    this.generalServicesCategories,
    this.generalServicesSubCategories,
    this.generalServicesFeatures,
    this.generalServicesEligibility,
  });

  GeneralServiceInfoJson.fromJson(Map<String, dynamic> json) {
    generalServicesCategories = json['generalServicesCategories']?.cast<String>() ?? [];
    generalServicesSubCategories = json['generalServicesSubCategories']?.cast<String>() ?? [];
    generalServicesFeatures = json['generalServicesFeatures']?.cast<String>() ?? [];
    generalServicesEligibility = json['generalServicesEligibility']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generalServicesCategories'] = this.generalServicesCategories;
    data['generalServicesSubCategories'] = this.generalServicesSubCategories;
    data['generalServicesFeatures'] = this.generalServicesFeatures;
    data['generalServicesEligibility'] = this.generalServicesEligibility;
    return data;
  }

  GeneralServiceInfo toDomain() {
    return GeneralServiceInfo(
      generalServicesCatagories: generalServicesCategories ?? [],
      generalServicesSubCatagories: generalServicesSubCategories ?? [],
      generalServicesFeatures: generalServicesFeatures ?? [],
      generalServicesEligibilty: generalServicesEligibility ?? [],
    );
  }

  GeneralServiceInfoJson copyWith({
    List<String>? generalServicesCategories,
    List<String>? generalServicesSubCategories,
    List<String>? generalServicesFeatures,
    List<String>? generalServicesEligibility,
  }) {
    return GeneralServiceInfoJson(
      generalServicesCategories: generalServicesCategories ?? this.generalServicesCategories,
      generalServicesSubCategories: generalServicesSubCategories ?? this.generalServicesSubCategories,
      generalServicesFeatures: generalServicesFeatures ?? this.generalServicesFeatures,
      generalServicesEligibility: generalServicesEligibility ?? this.generalServicesEligibility,
    );
  }
}
