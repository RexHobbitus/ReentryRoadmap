import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';

class ProviderReviewJson {
  String? id;
  double? rating;
  String? review;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<dynamic>? images;
  List<String>? likedBy;
  bool? isAnonymousUser;
  String? uploadedBy;

  ProviderReviewJson(
      {this.id,
      this.rating,
      this.review,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.likedBy,
      this.isAnonymousUser,

      this.uploadedBy});

  ProviderReviewJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    images = json['images']?.cast<String>()??[];
    likedBy = json['likedBy']?.cast<String>()??[];
    isAnonymousUser = json['isAnonymousUser'];
    uploadedBy = json['uploadedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['images'] = this.images;
    data['likedBy'] = this.likedBy;
    data['isAnonymousUser'] = this.isAnonymousUser;
    data['uploadedBy'] = this.uploadedBy;
    return data;
  }

  ProviderReview toDomain() {
    return ProviderReview(
        id: id,
        rating: rating ?? 0,
        review: review ?? "",
        createdAt: createdAt?.toDate().toString(),
        updatedAt: createdAt?.toDate().toString(),
        images: images??[],
        likedBy: likedBy,
        uploadedBy: uploadedBy);
  }
}
