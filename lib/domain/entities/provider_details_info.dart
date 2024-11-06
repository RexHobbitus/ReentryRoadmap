import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

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
  List<dynamic>? images;
  List<dynamic>? photosByOther;
  String? officialNumber;
  String? officialEmail;
  String? officialFax;
  String? contactPerson;
  String? orgWebsite;
  List<OperatingHour>? operatingHours;
  GeoPoint? gpsLocation;

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
    this.photosByOther,
    this.officialNumber,
    this.officialEmail,
    this.officialFax,
    this.contactPerson,
    this.orgWebsite,
    this.operatingHours,
    this.gpsLocation,
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
    photosByOther = List<String>.from(json['photosByOther'] ?? []);
    officialNumber = json['officialNumber'];
    officialEmail = json['officialEmail'];
    officialFax = json['officialFax'];
    contactPerson = json['contactPerson'];
    orgWebsite = json['orgWebsite'];
    if (json['operatingHours'] != null) {
      operatingHours = <OperatingHour>[];
      json['operatingHours'].forEach((v) {
        operatingHours!.add(OperatingHour.fromJson(v));
      });
    }
    gpsLocation = json['gpsLocation'];
  }

  ProviderDetailsInfo.shimmer() {
    providerNameLocation = "Testing";
    providerLocationDescribe = "Testing";
    relationReentry = "Testing";
    street = "Testing";
    city = "Testing";
    country = "Testing";
    state = "Testing";
    zipCode = "Testing";
    images = List.generate(5, (index) => kPlaceHolderImage);
    photosByOther = List.generate(5, (index) => kPlaceHolderImage);
    officialNumber = "Testing";
    officialEmail = "Testing";
    officialFax = "Testing";
    contactPerson = "Testing";
    orgWebsite = "Testing";
    operatingHours = List.generate(7, (index) => OperatingHour.shimmer());

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
    data['photosByOther'] = photosByOther;
    data['officialNumber'] = officialNumber;
    data['officialEmail'] = officialEmail;
    data['officialFax'] = officialFax;
    data['contactPerson'] = contactPerson;
    data['orgWebsite'] = orgWebsite;
    data['gpsLocation'] = gpsLocation;
    if (this.operatingHours != null) {
      data['operatingHours'] = this.operatingHours!.map((v) => v.toJson()).toList();
    }
    return data;
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
        photosByOther,
        officialNumber,
        officialEmail,
        officialFax,
        contactPerson,
        orgWebsite,
        operatingHours,
      gpsLocation
      ];

  ProviderDetailsInfo copyWith({
    String? providerNameLocation,
    String? providerLocationDescribe,
    String? relationReentry,
    String? street,
    String? city,
    String? country,
    String? state,
    String? zipCode,
    List<dynamic>? images,
    List<dynamic>? photosByOther,
    String? officialNumber,
    String? officialEmail,
    String? officialFax,
    String? contactPerson,
    String? orgWebsite,
    List<OperatingHour>? operatingHours,
    GeoPoint? gpsLocation,
  }) {
    return ProviderDetailsInfo(
      providerNameLocation: providerNameLocation ?? this.providerNameLocation,
      providerLocationDescribe: providerLocationDescribe ?? this.providerLocationDescribe,
      relationReentry: relationReentry ?? this.relationReentry,
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      images: images ?? this.images,
      photosByOther: photosByOther ?? this.photosByOther,
      officialNumber: officialNumber ?? this.officialNumber,
      officialEmail: officialEmail ?? this.officialEmail,
      officialFax: officialFax ?? this.officialFax,
      contactPerson: contactPerson ?? this.contactPerson,
      orgWebsite: orgWebsite ?? this.orgWebsite,
      operatingHours: operatingHours ?? this.operatingHours,
      gpsLocation: gpsLocation ?? this.gpsLocation,
    );
  }
}
