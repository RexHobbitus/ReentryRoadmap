class AppProvider {
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
}