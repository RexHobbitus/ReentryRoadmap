import 'package:reentry_roadmap/domain/entities/app_provider.dart';

class AppProviderJson {
  String? providerName;
  String? accessedDate;

  AppProviderJson({this.providerName, this.accessedDate});

  AppProviderJson.fromJson(Map<String, dynamic> json) {
    providerName = json['providerName'];
    accessedDate = json['accessedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['providerName'] = this.providerName;
    data['accessedDate'] = this.accessedDate;
    return data;
  }

  AppProvider toDomain() {
    return AppProvider(
      providerName: providerName,
      accessedDate: accessedDate,
    );
  }

  AppProviderJson copyWith({
    String? providerName,
    String? accessedDate,
  }) {
    return AppProviderJson(
      providerName: providerName ?? this.providerName,
      accessedDate: accessedDate ?? this.accessedDate,
    );
  }
}
