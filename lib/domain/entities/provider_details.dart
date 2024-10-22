import 'package:equatable/equatable.dart';

class ProviderDetails extends Equatable {
  String? providerNameLocation;
  String? providerLocationDescribe;
  String? relationReentry;
  String? street;
  String? city;
  String? country;
  String? state;
  String? zipCode;
  DateTime? startTime;
  DateTime? endTime;
  List<String>? images;
  String? officialNumber;
  String? officialEmail;
  String? officialFax;
  String? contactPerson;
  String? orgWebsite;

  ProviderDetails({
    this.providerNameLocation,
    this.providerLocationDescribe,
    this.relationReentry,
    this.street,
    this.city,
    this.country,
    this.state,
    this.zipCode,
    this.startTime,
    this.endTime,
    this.images,
    this.officialNumber,
    this.officialEmail,
    this.officialFax,
    this.contactPerson,
    this.orgWebsite,
  });

  ProviderDetails.fromJson(Map<String, dynamic> json) {
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
    return data;
  }

  ProviderDetails copyWith({
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
  }) {
    return ProviderDetails(
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
      ];
}
