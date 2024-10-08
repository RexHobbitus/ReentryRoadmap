import 'package:reentry_roadmap/domain/entities/app_provider.dart';

class AppProviderJson {
  String? providerName;
  String? providerLogo;
  String? accessedDate;

  AppProviderJson({this.providerName, this.providerLogo, this.accessedDate});

  AppProviderJson.fromJson(Map<String, dynamic> json) {
    providerName = json['providerName'];
    providerLogo = json['providerLogo'];
    accessedDate = json['accessedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['providerName'] = this.providerName;
    data['providerLogo'] = this.providerLogo;
    data['accessedDate'] = this.accessedDate;
    return data;
  }

  AppProvider toDomain() {
    return AppProvider(
      providerName: providerName,
      providerLogo: providerLogo,
      accessedDate: accessedDate,
    );
  }

  AppProviderJson copyWith({
    String? providerName,
    String? providerLogo,
    String? accessedDate,
  }) {
    return AppProviderJson(
      providerName: providerName ?? this.providerName,
      providerLogo: providerLogo ?? this.providerLogo,
      accessedDate: accessedDate ?? this.accessedDate,
    );
  }
}
