import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// This class to retrieve all the reviews for the current user
class UserReviewsService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference providersCollection = FirebaseFirestore.instance.collection('providers');

  Future<List<Map<String, dynamic>>> getUserReviews() async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not logged in');
    }

    List<Map<String, dynamic>> userReviews = [];

    // Fetch all providers and find reviews for the logged-in user
    QuerySnapshot providersSnapshot = await providersCollection.get();

    for (var providerDoc in providersSnapshot.docs) {
      // Get the reviews collection of each provider
      CollectionReference reviewsCollection = providerDoc.reference.collection('reviews');

      // Fetch reviews where 'uploadedBy' is equal to the userId
      QuerySnapshot userReviewSnapshot = await reviewsCollection.where('uploadedBy', isEqualTo: userId).get();

      for (var reviewDoc in userReviewSnapshot.docs) {
        // Add review data to the userReviews list
        userReviews.add(reviewDoc.data() as Map<String, dynamic>);
      }
    }

    print('Total user reviews fetched: ${userReviews.length}');
    return userReviews;
  }
}
