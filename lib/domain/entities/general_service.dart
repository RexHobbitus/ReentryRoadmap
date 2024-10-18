import 'package:equatable/equatable.dart';

class GeneralService extends Equatable {
  List<String>? generalServicesCatagories;
  List<String>? generalServicesSubCatagories;
  List<String>? generalServicesFeatures;
  List<String>? generalServicesEligibilty;

  GeneralService(
      {
      this.generalServicesCatagories,
      this.generalServicesSubCatagories,
      this.generalServicesFeatures,
      this.generalServicesEligibilty});

  GeneralService.fromJson(Map<String, dynamic> json) {
    generalServicesCatagories =
        List<String>.from(json['generalServicesCatagories'] ?? []);

    generalServicesSubCatagories =
        List<String>.from(json['generalServicesSubCatagories'] ?? []);
    generalServicesFeatures =
        List<String>.from(json['generalServicesFeatures'] ?? []);
    generalServicesEligibilty =
        List<String>.from(json['generalServicesEligibilty'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generalServicesCatagories'] = generalServicesCatagories;

    data['generalServicesSubCatagories'] = generalServicesSubCatagories;
    data['generalServicesFeatures'] = generalServicesCatagories;
    data['generalServicesEligibilty'] = generalServicesCatagories;
    return data;
  }

  GeneralService copyWith({
    List<String>? generalServicesCatagories,
    List<String>? generalServicesSubCatagories,
    List<String>? generalServicesFeatures,
    List<String>? generalServicesEligibilty,
  }) {
    return GeneralService(
      generalServicesCatagories:
          generalServicesCatagories ?? this.generalServicesCatagories,
      generalServicesSubCatagories:
          generalServicesSubCatagories ?? this.generalServicesSubCatagories,
      generalServicesFeatures: generalServicesFeatures ?? this.generalServicesFeatures,
      generalServicesEligibilty:
          generalServicesEligibilty ?? this.generalServicesEligibilty,
    );
  }

  @override
  List<Object?> get props => [
        generalServicesCatagories,
        generalServicesSubCatagories,
        generalServicesFeatures,
        generalServicesFeatures
      ];
}
