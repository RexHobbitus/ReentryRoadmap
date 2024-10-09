import 'package:reentry_roadmap/data/models/service_provider_json.dart';
import 'package:reentry_roadmap/domain/entities/service_provider.dart';

import '../../domain/entities/service_provider_accessed.dart';

class ServiceProviderAccessedJson {
  List<ServiceProviderJson>? serviceProviders;

  ServiceProviderAccessedJson({this.serviceProviders});

  ServiceProviderAccessedJson.fromJson(Map<String, dynamic> json) {
    if (json['serviceProvider'] != null) {
      serviceProviders = <ServiceProviderJson>[];
      json['serviceProvider'].forEach((v) {
        serviceProviders!.add(new ServiceProviderJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceProviders != null) {
      data['serviceProvider'] =
          this.serviceProviders!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ServiceProviderAccessed toDomain() {
    return ServiceProviderAccessed(
      serviceProviders: serviceProviders
          ?.map((providerJson) => providerJson.toDomain())
          .toList(),
    );
  }
}
