
import 'package:reentry_roadmap/domain/entities/program_offer_info.dart';

class ProgramOfferInfoJson {
  String? describeProgram;
  List<String>? applyProgramCategories;
  List<String>? applyProgramSubCategories;
  List<String>? applyProgramFeatures;
  List<String>? applyProgramEligibility;

  ProgramOfferInfoJson({
    this.describeProgram,
    this.applyProgramCategories,
    this.applyProgramSubCategories,
    this.applyProgramFeatures,
    this.applyProgramEligibility,
  });

  ProgramOfferInfoJson.fromJson(Map<String, dynamic> json) {
    describeProgram = json['describeProgram'];
    applyProgramCategories = json['applyProgramCategories']?.cast<String>() ?? [];
    applyProgramSubCategories = json['applyProgramSubCategories']?.cast<String>() ?? [];
    applyProgramFeatures = json['applyProgramFeatures']?.cast<String>() ?? [];
    applyProgramEligibility = json['applyProgramEligibility']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['describeProgram'] = this.describeProgram;
    data['applyProgramCategories'] = this.applyProgramCategories;
    data['applyProgramSubCategories'] = this.applyProgramSubCategories;
    data['applyProgramFeatures'] = this.applyProgramFeatures;
    data['applyProgramEligibility'] = this.applyProgramEligibility;
    return data;
  }

  ProgramOfferInfo toDomain() {
    return ProgramOfferInfo(
      describeProgram: describeProgram ?? '',
      applyProgramCatagories: applyProgramCategories ?? [],
      applyProgramSubCatagories: applyProgramSubCategories ?? [],
      applyProgramFeatures: applyProgramFeatures ?? [],
      applyProgramEligibilty: applyProgramEligibility ?? [],
    );
  }

  ProgramOfferInfoJson copyWith({
    String? describeProgram,
    List<String>? applyProgramCategories,
    List<String>? applyProgramSubCategories,
    List<String>? applyProgramFeatures,
    List<String>? applyProgramEligibility,
  }) {
    return ProgramOfferInfoJson(
      describeProgram: describeProgram ?? this.describeProgram,
      applyProgramCategories: applyProgramCategories ?? this.applyProgramCategories,
      applyProgramSubCategories: applyProgramSubCategories ?? this.applyProgramSubCategories,
      applyProgramFeatures: applyProgramFeatures ?? this.applyProgramFeatures,
      applyProgramEligibility: applyProgramEligibility ?? this.applyProgramEligibility,
    );
  }
}
