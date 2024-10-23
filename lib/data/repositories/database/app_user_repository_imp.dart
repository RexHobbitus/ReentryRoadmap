import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import '../../../domain/entities/onboarding_info.dart';

class AppUserRepositoryImp extends FirebaseCollection
   with FirebaseFunctions implements AppUserRepository {

  @override
  Future<void> submitAssessment(OnboardingInfo onboardingInfo) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final docRef = usersCollection.doc(user.uid);

      // Getting the current timestamp
      final timestamp = FieldValue.serverTimestamp();

      // Creating the JSON object to be stored
      final userData = {
        'userId': user.uid,
        'email': user.email,
        'createdAt': timestamp,
        'updatedAt': timestamp,
        'onboardingInfo': onboardingInfo.toJson(),
      };

      await docRef.set(userData,
          SetOptions(merge: true)); // Using merge to update existing document

    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }

  @override
  Future<void> giveReviewToProvider(
      {required String providerId, required ProviderReview review}) async {
    DocumentReference ref = providersCollection.doc(providerId).collection(
        "reviews").doc();
    review.id = ref.id;
    review.uploadedBy=auth.currentUser?.uid;
    review.images=await uploadFiles(review.images??[]);
    await providersCollection.doc(providerId).collection("reviews").doc(ref.id).set(
        review.toData().toJson());
  }
}
