import 'package:reentry_roadmap/domain/entities/current_needs_info.dart';

import 'app_provider_json.dart';

class CurrentNeedsInfoJson {
  List<AppProviderJson>? providers;

  CurrentNeedsInfoJson({this.providers});

  CurrentNeedsInfoJson.fromJson(Map<String, dynamic> json) {
    if (json['providers'] != null) {
      providers = <AppProviderJson>[];
      json['providers'].forEach((v) {
        providers!.add(AppProviderJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.providers != null) {
      data['providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CurrentNeedsInfo toDomain() {
    return CurrentNeedsInfo(
      providers: providers?.map((provider) => provider.toDomain()).toList(),
    );
  }

  CurrentNeedsInfoJson copyWith({
    List<AppProviderJson>? providers,
  }) {
    return CurrentNeedsInfoJson(
      providers: providers ?? this.providers,
    );
  }
}
