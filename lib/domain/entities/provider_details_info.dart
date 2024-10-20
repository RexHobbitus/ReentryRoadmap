import 'package:equatable/equatable.dart';

import 'operating_hour.dart';

class ProviderDetailsInfo extends Equatable {
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
  String? ratings;
  List<String>? reviews;
  List<OperatingHour>? operatingHours;

  ProviderDetailsInfo({
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
    this.ratings,
    this.reviews,
    this.operatingHours,
  });

  ProviderDetailsInfo.fromJson(Map<String, dynamic> json) {
    providerNameLocation = json['providerNameLocation'];
    providerLocationDescribe = json['providerLocationDescribe'];
    relationReentry = json['relationReentry'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    zipCode = json['zipCode'];
    images = List<String>.from(json['images'] ?? []);
    officialNumber = json['officialNumber'];
    officialEmail = json['officialEmail'];
    officialFax = json['officialFax'];
    contactPerson = json['contactPerson'];
    orgWebsite = json['orgWebsite'];
    ratings = json['ratings'];
    reviews = json['reviews'] ?? [];
    if (json['operatingHours'] != null) {
      operatingHours = <OperatingHour>[];
      json['operatingHours'].forEach((v) {
        operatingHours!.add(OperatingHour.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['providerNameLocation'] = providerNameLocation;
    data['providerLocationDescribe'] = providerLocationDescribe;
    data['relationReentry'] = relationReentry;
    data['street'] = street;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['images'] = images;
    data['officialNumber'] = officialNumber;
    data['officialEmail'] = officialEmail;
    data['officialFax'] = officialFax;
    data['contactPerson'] = contactPerson;
    data['orgWebsite'] = orgWebsite;
    data['ratings'] = ratings;
    data['reviews'] = reviews;
    if (this.operatingHours != null) {
      data['operatingHours'] =
          this.operatingHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ProviderDetailsInfo copyWith({
    String? providerNameLocation,
    String? providerLocationDescribe,
    String? relationReentry,
    String? street,
    String? city,
    String? country,
    String? state,
    String? zipCode,
    List<String>? images,
    String? officialNumber,
    String? officialEmail,
    String? officialFax,
    String? contactPerson,
    String? orgWebsite,
    String? ratings,
    List<String>? reviews,
    List<OperatingHour>? operatingHours,
  }) {
    return ProviderDetailsInfo(
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
      ratings: ratings ?? this.ratings,
      reviews: reviews ?? this.reviews,
      operatingHours: operatingHours ?? this.operatingHours,
    );
  }

  @override
  List<Object?> get props => [
        providerNameLocation,
        providerLocationDescribe,
        relationReentry,
        street,
        city,
        country,
        state,
        zipCode,
        images,
        officialNumber,
        officialEmail,
        officialFax,
        contactPerson,
        orgWebsite,
        ratings,
        reviews,
        operatingHours,
      ];
}
