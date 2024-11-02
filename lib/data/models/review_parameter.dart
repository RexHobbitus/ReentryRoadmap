import 'dart:io';

/// You can edit this to post any data we want to store for review
class ReviewParameter {
  final double rating;
  final String review;
  final List<dynamic> images;
  final bool postAnonymously;
  final Map<String, int> ratings;
  final String uploadTime = DateTime.now().toIso8601String();


  ReviewParameter({
  required this.rating,
  required this.review,
  required this.images,
  required this.postAnonymously,
  required this.ratings,
});
}
