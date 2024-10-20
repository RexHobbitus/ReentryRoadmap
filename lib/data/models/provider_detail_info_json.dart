import 'package:reentry_roadmap/domain/entities/provider_details_info.dart';

import 'operating_hour_json.dart';

class ProviderDetailInfoJson {
  String? providerNameLocation;
  String? providerLocationDescribe;
  String? relationReentry;
  String? street;
  String? city;
  String? country;
  String? state;
  String? zipCode;
  List<String>? images;
  String? officialNumber;
  String? officialEmail;
  String? officialFax;
  String? contactPerson;
  String? orgWebsite;
  List<OperatingHourJson>? operatingHours;

  ProviderDetailInfoJson({
    this.providerNameLocation,
    this.providerLocationDescribe,
    this.relationReentry,
    this.street,
    this.city,
    this.country,
    this.state,
    this.zipCode,
    this.images,
    this.officialNumber,
    this.officialEmail,
    this.officialFax,
    this.contactPerson,
    this.orgWebsite,
    this.operatingHours,
  });

  ProviderDetailInfoJson.fromJson(Map<String, dynamic> json) {
    providerNameLocation = json['providerNameLocation'];
    providerLocationDescribe = json['providerLocationDescribe'];
    relationReentry = json['relationReentry'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    zipCode = json['zipCode'];
    images = json['images']?.cast<String>() ?? [];
    officialNumber = json['officialNumber'];
    officialEmail = json['officialEmail'];
    officialFax = json['officialFax'];
    contactPerson = json['contactPerson'];
    orgWebsite = json['orgWebsite'];
    if (json['operatingHours'] != null) {
      operatingHours = <OperatingHourJson>[];
      json['operatingHours'].forEach((v) {
        operatingHours!.add(OperatingHourJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerNameLocation'] = this.providerNameLocation;
    data['providerLocationDescribe'] = this.providerLocationDescribe;
    data['relationReentry'] = this.relationReentry;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['images'] = this.images;
    data['officialNumber'] = this.officialNumber;
    data['officialEmail'] = this.officialEmail;
    data['officialFax'] = this.officialFax;
    data['contactPerson'] = this.contactPerson;
    data['orgWebsite'] = this.orgWebsite;
    if (this.operatingHours != null) {
      data['operatingHours'] =
          this.operatingHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ProviderDetailsInfo toDomain() {
    return ProviderDetailsInfo(
      providerNameLocation: providerNameLocation ?? '',
      providerLocationDescribe: providerLocationDescribe ?? '',
      relationReentry: relationReentry ?? '',
      street: street ?? '',
      city: city ?? '',
      country: country ?? '',
      state: state ?? '',
      zipCode: zipCode ?? '',
      images: images ?? [],
      officialNumber: officialNumber ?? '',
      officialEmail: officialEmail ?? '',
      officialFax: officialFax ?? '',
      contactPerson: contactPerson ?? '',
      orgWebsite: orgWebsite ?? '',
      operatingHours: operatingHours?.map((data)=>data.toDomain()).toList()??[],
    );
  }

  ProviderDetailInfoJson copyWith({
    String? providerNameLocation,
    String? providerLocationDescribe,
    String? relationReentry,
    String? street,
    String? city,
    String? country,
    String? state,
    String? zipCode,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? images,
    String? officialNumber,
    String? officialEmail,
    String? officialFax,
    String? contactPerson,
    String? orgWebsite,
    List<OperatingHourJson>? operatingHours,
  }) {
    return ProviderDetailInfoJson(
      providerNameLocation: providerNameLocation ?? this.providerNameLocation,
      providerLocationDescribe:
          providerLocationDescribe ?? this.providerLocationDescribe,
      relationReentry: relationReentry ?? this.relationReentry,
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      images: images ?? this.images,
      officialNumber: officialNumber ?? this.officialNumber,
      officialEmail: officialEmail ?? this.officialEmail,
      officialFax: officialFax ?? this.officialFax,
      contactPerson: contactPerson ?? this.contactPerson,
      orgWebsite: orgWebsite ?? this.orgWebsite,
      operatingHours: operatingHours ?? this.operatingHours,
    );
  }
}
