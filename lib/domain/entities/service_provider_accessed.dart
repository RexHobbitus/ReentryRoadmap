import 'package:equatable/equatable.dart';
import 'package:reentry_roadmap/domain/entities/service_provider.dart';

class ServiceProviderAccessed extends Equatable {
  List<ServiceProvider>? serviceProviders;

  ServiceProviderAccessed({this.serviceProviders});

  ServiceProviderAccessed.fromJson(Map<String, dynamic> json) {
    if (json['serviceProvider'] != null) {
      serviceProviders = <ServiceProvider>[];
      json['serviceProvider'].forEach((v) {
        serviceProviders!.add(new ServiceProvider.fromJson(v));
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

  ServiceProviderAccessed copyWith({
    List<ServiceProvider>? serviceProviders,
  }) {
    return ServiceProviderAccessed(
      serviceProviders: serviceProviders ?? this.serviceProviders,
    );
  }

  @override
  List<Object?> get props => [serviceProviders];
}
