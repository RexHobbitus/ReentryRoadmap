
import 'package:reentry_roadmap/domain/entities/amzing_sauce_program_info.dart';

class AmazingSauceInfoJson {
  String? describeProgram;
  List<String>? applyProgramCategories;
  List<String>? applyProgramSubCategories;
  List<String>? applyProgramFeatures;
  List<String>? applyProgramEligibility;

  AmazingSauceInfoJson({
    this.describeProgram,
    this.applyProgramCategories,
    this.applyProgramSubCategories,
    this.applyProgramFeatures,
    this.applyProgramEligibility,
  });

  AmazingSauceInfoJson.fromJson(Map<String, dynamic> json) {
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

  AmzingSauceProgramInfo toDomain() {
    return AmzingSauceProgramInfo(
      describeProgram: describeProgram ?? '',
      applyProgramCatagories: applyProgramCategories ?? [],
      applyProgramSubCatagories: applyProgramSubCategories ?? [],
      applyProgramFeatures: applyProgramFeatures ?? [],
      applyProgramEligibilty: applyProgramEligibility ?? [],
    );
  }

  AmazingSauceInfoJson copyWith({
    String? describeProgram,
    List<String>? applyProgramCategories,
    List<String>? applyProgramSubCategories,
    List<String>? applyProgramFeatures,
    List<String>? applyProgramEligibility,
  }) {
    return AmazingSauceInfoJson(
      describeProgram: describeProgram ?? this.describeProgram,
      applyProgramCategories: applyProgramCategories ?? this.applyProgramCategories,
      applyProgramSubCategories: applyProgramSubCategories ?? this.applyProgramSubCategories,
      applyProgramFeatures: applyProgramFeatures ?? this.applyProgramFeatures,
      applyProgramEligibility: applyProgramEligibility ?? this.applyProgramEligibility,
    );
  }
}
