import 'package:reentry_roadmap/data/models/service_provider_accessed.dart';

import '../../domain/entities/service_provider_accessed.dart';

class ServiceProviderAccessedDataModel {
  List<ServiceProviderDataModel>? serviceProviders;

  ServiceProviderAccessedDataModel({this.serviceProviders});

  ServiceProviderAccessedDataModel.fromJson(Map<String, dynamic> json) {
    if (json['serviceProvider'] != null) {
      serviceProviders = <ServiceProviderDataModel>[];
      // Check if the serviceProvider is a List
      for (var v in json['serviceProvider']) {
        serviceProviders!.add(ServiceProviderDataModel.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.serviceProviders != null) {
      data['serviceProvider'] =
          this.serviceProviders!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}
