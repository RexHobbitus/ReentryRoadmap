import 'package:cloud_firestore/cloud_firestore.dart';

/// The service provider accessed data model is a demo model for the real one
/// we need to update it and add more data to the service
class ServiceProviderDataModel {
  final String? name;
  final String? address;
  final DateTime? accessedDate; // DateTime instead of Timestamp
  final String? imgUrl;

  ServiceProviderDataModel({
    this.name,
    this.address,
    this.accessedDate,
    this.imgUrl,
  });

  factory ServiceProviderDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderDataModel(
      name: json['name'] as String?,
      address: json['address'] as String?,
      accessedDate: (json['accessedDate'] as Timestamp?)?.toDate(), // Convert Timestamp to DateTime
      imgUrl: json['imgUrl'] as String?,
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

  @override
  String toString() {
    return 'ServiceProviderDataModel(name: $name, address: $address, accessedDate: $accessedDate, imgUrl: $imgUrl)';
  }
}
