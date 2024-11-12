import 'package:equatable/equatable.dart';
import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

class MyService extends Equatable {
  String? serviceId;
  Provider? provider;
  List<String>? statusUpdates;
  MyServicesStatus? serviceStatus;

  MyService({this.serviceId,this.provider, this.serviceStatus, this.statusUpdates});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceId'] = serviceId;
    data['provider'] = provider?.toJson();
    data['statusUpdates'] = statusUpdates;
    data['serviceStatus'] = serviceStatus?.name;

    return data;
  }

  MyService.fromJson(Map<String, dynamic> json) {
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    statusUpdates = json['statusUpdates'];
    serviceStatus = MyServicesStatus.values.firstWhere(json["serviceStatus"]);
    serviceId = json["serviceId"];
  }

  @override
  List<Object?> get props => [provider, statusUpdates, serviceStatus];
}
