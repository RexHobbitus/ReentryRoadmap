import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../../domain/entities/provider.dart';
import '../../models/provider_json.dart';
import '../../models/review_parameter.dart';

/// This file is for updating reviews in database

class ReviewService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference providersCollection = FirebaseFirestore.instance.collection('providers');

  Future<void> submitReview({
    required String providerId,
    required ReviewParameter review,
  }) async {
    // Ensure user is logged in
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not logged in');
    }

    // Reference for the review document, using user ID as document ID
    DocumentReference reviewRef = providersCollection
        .doc(providerId)
        .collection("reviews")
        .doc(userId);  // Use user ID as document ID

    final reviewData = {
      'rating': review.rating,
      'review': review.review,
      'images': await uploadFiles(review.images),
      'postAnonymously': review.postAnonymously,
      'ratings': review.ratings,
      'uploadedBy': userId,
      'uploadTime': review.uploadTime,
    };

    // Set review document in the provider's `reviews` collection
    await reviewRef.set(reviewData);
  }

  Future<List<String>> uploadFiles(List<dynamic> images) async {
    List<String> urls = [];
    for (var image in images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child("reviews/$fileName");

      // Check if image is a File (for mobile) or Uint8List (for web)
      if (image is File) {
        UploadTask uploadTask = ref.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        urls.add(url);
      } else if (image is Uint8List) {
        UploadTask uploadTask = ref.putData(image);
        final snapshot = await uploadTask.whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        urls.add(url);
      }
    }
    return urls;
  }
}
