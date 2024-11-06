import 'package:equatable/equatable.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

class CeoInfo extends Equatable {
  String? name;
  String? profilePic;
  String? position;

  CeoInfo({this.name, this.profilePic, this.position});

  CeoInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profilePic'];
    position = json['position'];
  }
  CeoInfo.shimmer() {
    name = "John Doe";
    profilePic = kPlaceHolderImage;
    position = "CEO ${kAppName}";
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['position'] = this.position;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        profilePic,
        position,
      ];
}
