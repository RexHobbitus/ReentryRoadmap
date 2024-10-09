import 'package:equatable/equatable.dart';

class AppProvider extends Equatable {
  String? providerName;
  String? accessedDate;

  AppProvider({this.providerName, this.accessedDate});

  AppProvider.fromJson(Map<String, dynamic> json) {
    providerName = json['providerName'];
    accessedDate = json['accessedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerName'] = this.providerName;
    data['accessedDate'] = this.accessedDate;
    return data;
  }

  AppProvider copyWith({
    String? providerName,
    String? providerLogo,
    String? accessedDate,
  }) {
    return AppProvider(
      providerName: providerName ?? this.providerName,
      accessedDate: accessedDate ?? this.accessedDate,
    );
  }

  @override
  List<Object?> get props => [
        providerName,
        accessedDate,
      ];
}
