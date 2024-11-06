import 'package:reentry_roadmap/core/utils/constants.dart';

class FeaturedProviderOurTake {
  String? id;
  String? providerId;
  String? name;
  String? ourTake;
  String? profilePic;
  String? rating;
  String? website;

  FeaturedProviderOurTake(
      {this.id,
        this.providerId,
        this.name,
        this.ourTake,
        this.profilePic,
        this.rating,
        this.website});

  FeaturedProviderOurTake.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['providerId'];
    name = json['name'];
    ourTake = json['ourTake'];
    profilePic = json['profilePic'];
    rating = json['rating'];
    website = json['website'];
  }
  FeaturedProviderOurTake.shimmer() {
    id = "";
    providerId = "";
    name = "Dummy name";
    ourTake = "Dummy testing featured provider Dummy testing featured provider Dummy testing featured provider Dummy testing featured provider Dummy testing featured provider Dummy testing featured provider";
    profilePic = kPlaceHolderImage;
    rating = "3.5";
    website = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['providerId'] = this.providerId;
    data['name'] = this.name;
    data['ourTake'] = this.ourTake;
    data['profilePic'] = this.profilePic;
    data['rating'] = this.rating;
    data['website'] = this.website;
    return data;
  }
}
