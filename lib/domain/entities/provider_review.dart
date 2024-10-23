import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/data/models/provider_review_json.dart';

class ProviderReview {
  String? id;
  double? rating;
  String? review;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? images;
  List<String>? likedBy;

  bool? isAnonymousUser;
  String? uploadedBy;

  ProviderReview({
    this.rating,
    this.id,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.isAnonymousUser,
    this.uploadedBy,
    this.likedBy,
  });

  ProviderReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    images = json['images']?.cast<String>()??[];
    isAnonymousUser = json['isAnonymousUser'];
    uploadedBy = json['uploadedBy'];
    likedBy = json['likedBy'].cast<String>();
  }

  ProviderReview.shimmer() {
    rating = 5.0;
    review = "This is dummy data just for placeholder/shimmer effect";
    createdAt = "28-10-1999";
    updatedAt = "28-10-1999";
    images =List.generate(2, (index)=>kPlaceHolderImage);
    isAnonymousUser = false;
    likedBy=[];
  }


  ProviderReviewJson toData() {
    return ProviderReviewJson(
      id: id,
      review: review,
      rating: rating,
      images: images ?? [],
      likedBy: likedBy ?? [],
      isAnonymousUser: isAnonymousUser,
      uploadedBy: uploadedBy,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['id'] = this.id;
    data['review'] = this.review;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['images'] = this.images;
    data['isAnonymousUser'] = this.isAnonymousUser;
    data['uploadedBy'] = this.uploadedBy;
    data['likedBy'] = this.likedBy;
    return data;
  }
}
