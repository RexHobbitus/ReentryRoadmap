import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';

class MyServiceJson {
  String? serviceId;
  ProviderJson? provider;
  List<String>? statusUpdates;
  MyServicesStatus? serviceStatus;

  MyServiceJson({this.serviceId,this.provider, this.serviceStatus, this.statusUpdates});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['serviceId'] = serviceId;
    data['provider'] = provider?.toJson();
    data['statusUpdates'] = statusUpdates;
    data['serviceStatus'] = serviceStatus?.name;

    return data;
  }

  MyServiceJson.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? ProviderJson.fromJson(json['provider'])
        : null;
    statusUpdates = json['statusUpdates'].cast<String>();
    serviceStatus = myServicesStatusFromString(json["serviceStatus"]);
    serviceId = json["serviceId"];
  }

  MyServicesStatus? myServicesStatusFromString(String myServiceStatus) {
    return MyServicesStatus.values.firstWhere(
      (myServicesStatus) =>
          myServicesStatus.toString().split('.').last == myServiceStatus,
      // Return null if no match is found
    );
  }

  MyService toDomain() {
    return MyService(
        serviceId: serviceId,
        provider: provider?.toDomain(),
        statusUpdates: statusUpdates,
        serviceStatus: serviceStatus);
  }
}
