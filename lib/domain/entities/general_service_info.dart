// import 'package:equatable/equatable.dart';
//
// class GeneralServiceInfo extends Equatable {
//   List<String>? generalServicesCatagories;
//   List<String>? generalServicesSubCatagories;
//   List<String>? generalServicesFeatures;
//   List<String>? generalServicesEligibilty;
//
//   GeneralServiceInfo(
//       {
//       this.generalServicesCatagories,
//       this.generalServicesSubCatagories,
//       this.generalServicesFeatures,
//       this.generalServicesEligibilty});
//
//   GeneralServiceInfo.fromJson(Map<String, dynamic> json) {
//     generalServicesCatagories =
//         List<String>.from(json['generalServicesCatagories'] ?? []);
//
//     generalServicesSubCatagories =
//         List<String>.from(json['generalServicesSubCatagories'] ?? []);
//     generalServicesFeatures =
//         List<String>.from(json['generalServicesFeatures'] ?? []);
//     generalServicesEligibilty =
//         List<String>.from(json['generalServicesEligibilty'] ?? []);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['generalServicesCatagories'] = generalServicesCatagories;
//
//     data['generalServicesSubCatagories'] = generalServicesSubCatagories;
//     data['generalServicesFeatures'] = generalServicesCatagories;
//     data['generalServicesEligibilty'] = generalServicesCatagories;
//     return data;
//   }
//
//   GeneralServiceInfo copyWith({
//     List<String>? generalServicesCatagories,
//     List<String>? generalServicesSubCatagories,
//     List<String>? generalServicesFeatures,
//     List<String>? generalServicesEligibilty,
//   }) {
//     return GeneralServiceInfo(
//       generalServicesCatagories:
//           generalServicesCatagories ?? this.generalServicesCatagories,
//       generalServicesSubCatagories:
//           generalServicesSubCatagories ?? this.generalServicesSubCatagories,
//       generalServicesFeatures: generalServicesFeatures ?? this.generalServicesFeatures,
//       generalServicesEligibilty:
//           generalServicesEligibilty ?? this.generalServicesEligibilty,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         generalServicesCatagories,
//         generalServicesSubCatagories,
//         generalServicesFeatures,
//         generalServicesFeatures
//       ];
// }
