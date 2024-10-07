
import 'app_provider.dart';

class CurrentNeedsInfo {
  List<AppProvider>? providers;

  CurrentNeedsInfo({this.providers});

  CurrentNeedsInfo.fromJson(Map<String, dynamic> json) {
    if (json['providers'] != null) {
      providers = <AppProvider>[];
      json['providers'].forEach((v) {
        providers!.add(new AppProvider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providers != null) {
      data['providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
