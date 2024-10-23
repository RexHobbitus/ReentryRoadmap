import 'package:equatable/equatable.dart';

class ProgramOfferInfo extends Equatable {
  String? describeProgram;
  List<String>? applyProgramCatagories;
  List<String>? applyProgramSubCatagories;
  List<String>? applyProgramFeatures;
  List<String>? applyProgramEligibilty;

  ProgramOfferInfo(
      {this.describeProgram,
      this.applyProgramCatagories,
      this.applyProgramSubCatagories,
      this.applyProgramFeatures,
      this.applyProgramEligibilty});

  ProgramOfferInfo.fromJson(Map<String, dynamic> json) {
    describeProgram = json['describeProgram'];
    applyProgramCatagories =
        List<String>.from(json['applyProgramCatagories'] ?? []);

    applyProgramSubCatagories =
        List<String>.from(json['applyProgramSubCatagories'] ?? []);
    applyProgramFeatures =
        List<String>.from(json['applyProgramFeatures'] ?? []);
    applyProgramEligibilty =
        List<String>.from(json['applyProgramEligibilty'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['describeProgram'] = describeProgram;
    data['applyProgramCatagories'] = applyProgramCatagories;

    data['applyProgramSubCatagories'] = applyProgramSubCatagories;
    data['applyProgramFeatures'] = applyProgramCatagories;
    data['applyProgramEligibilty'] = applyProgramCatagories;
    return data;
  }

  ProgramOfferInfo copyWith({
    String? describeProgram,
    List<String>? applyProgramCatagories,
    List<String>? applyProgramSubCatagories,
    List<String>? applyProgramFeatures,
    List<String>? applyProgramEligibilty,
  }) {
    return ProgramOfferInfo(
      describeProgram: describeProgram ?? this.describeProgram,
      applyProgramCatagories:
          applyProgramCatagories ?? this.applyProgramCatagories,
      applyProgramSubCatagories:
          applyProgramSubCatagories ?? this.applyProgramSubCatagories,
      applyProgramFeatures: applyProgramFeatures ?? this.applyProgramFeatures,
      applyProgramEligibilty:
          applyProgramEligibilty ?? this.applyProgramEligibilty,
    );
  }

  @override
  List<Object?> get props => [
        describeProgram,
        applyProgramCatagories,
        applyProgramSubCatagories,
        applyProgramFeatures,
        applyProgramFeatures
      ];
}
