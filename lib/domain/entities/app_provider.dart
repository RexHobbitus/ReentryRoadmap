import 'package:equatable/equatable.dart';

class AppProvider extends Equatable {
  String? providerName;
  String? providerLogo;
  String? accessedDate;

  AppProvider({this.providerName, this.providerLogo, this.accessedDate});

  AppProvider.fromJson(Map<String, dynamic> json) {
    providerName = json['providerName'];
    providerLogo = json['providerLogo'];
    accessedDate = json['accessedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerName'] = this.providerName;
    data['providerLogo'] = this.providerLogo;
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
      providerLogo: providerLogo ?? this.providerLogo,
      accessedDate: accessedDate ?? this.accessedDate,
    );
  }

  @override
  List<Object?> get props => [
        providerName,
        providerLogo,
        accessedDate,
      ];
}
