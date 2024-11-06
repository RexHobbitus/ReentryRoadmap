import 'package:reentry_roadmap/domain/entities/featured_provider_our_take.dart';

class FeaturedProviderOurTakeJson {
  String? id;
  String? providerId;
  String? name;
  String? ourTake;
  String? profilePic;
  String? rating;
  String? website;

  FeaturedProviderOurTakeJson(
      {this.id,
      this.providerId,
      this.name,
      this.ourTake,
      this.profilePic,
      this.rating,
      this.website});

  FeaturedProviderOurTakeJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['providerId'];
    name = json['name'];
    ourTake = json['ourTake'];
    profilePic = json['profilePic'];
    rating = json['rating'];
    website = json['website'];
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

  FeaturedProviderOurTake toDomain() {
    return FeaturedProviderOurTake(
      id: id,
      providerId: providerId,
      name: name,
      ourTake: ourTake,
      profilePic: profilePic,
      rating: rating,
      website: website,
    );
  }
}
