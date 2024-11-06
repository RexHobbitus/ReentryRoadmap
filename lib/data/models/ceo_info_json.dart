import 'package:reentry_roadmap/domain/entities/ceo_info.dart';

class CeoInfoJson {
  String? name;
  String? profilePic;
  String? position;

  CeoInfoJson({this.name, this.profilePic, this.position});

  CeoInfoJson.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profilePic'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['position'] = this.position;
    return data;
  }

  CeoInfo toDomain() {
    return CeoInfo(
      name: name,
      profilePic: profilePic,
      position: position,
    );
  }
}
