import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/service_provider.dart';

class ServiceProviderJson {
  String? name;
  String? address;

  Timestamp? accessedDate;
  String? imgUrl;

  ServiceProviderJson({
    this.name,
    this.accessedDate,
    this.imgUrl,
    this.address,
  });

  factory ServiceProviderJson.fromJson(Map<String, dynamic> json) {
    return ServiceProviderJson(
      name: json['name'],
      address: json['address'],
      accessedDate: json['accessedDate'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'accessedDate': accessedDate,
      'imgUrl': imgUrl,
    };
  }

  ServiceProviderJson copyWith({
    String? name,
    String? address,
    Timestamp? accessedDate,
    String? imgUrl,
  }) {
    return ServiceProviderJson(
      name: name ?? this.name,
      address: address ?? this.address,
      accessedDate: accessedDate ?? this.accessedDate,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  ServiceProvider toDomain() {
    // Assuming a ServiceProvider class exists with the same properties
    return ServiceProvider(
      name: name,
      address: address,
      accessedDate: accessedDate?.toDate(),
      imgUrl: imgUrl,
    );
  }
}
