import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/models/app_user_json.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import '../../../domain/entities/check_in.dart';
import '../../../domain/entities/onboarding_info.dart';
import '../../../domain/entities/provider.dart';
import 'dart:developer' as logger;

class AppUserRepositoryImp extends FirebaseCollection
    with FirebaseFunctions
    implements AppUserRepository {
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
    DocumentReference ref =
        providersCollection.doc(providerId).collection("reviews").doc();
    Provider provider = await getProviderFromId(id: providerId);
    review.id = ref.id;
    review.uploadedBy = auth.currentUser?.uid;
    review.images = await uploadFiles(review.images ?? []);
    // Update the specific star rating count
    final ratingKey = review.rating?.toInt().toString() ?? 1;
    final newRatingCount = (provider.ratingCount?.toJson()[ratingKey] ?? 0) + 1;

    await providersCollection
        .doc(provider.userId)
        .collection("reviews")
        .doc(ref.id)
        .set(review.toData().toJson());
    final newTotalReviews = (provider.totalReviews ?? 0) + 1;
    logger.log("++++ REVIEW ADDED INTO REVIEW SUB COLLECTION +++++++");
    final newAvgRating =
        (((provider.avgRating ?? 0) * (provider.totalReviews ?? 0)) +
                review.rating!) /
            newTotalReviews;
    await providersCollection.doc(provider.userId).update({
      "avgRating": newAvgRating,
      "totalReviews": FieldValue.increment(1),
      'ratingCount.$ratingKey': newRatingCount,
    });
    logger.log("++++ AVG RATING UPDADTED +++++++");
  }

  @override
  Future<AppUser> getUserFromId({required String id}) async {
    DocumentSnapshot doc = await usersCollection.doc(id).get();
    if (!doc.exists) {
      return AppUser.deletedUser();
    }
    return AppUserJson.fromJson(doc.data() as Map<String, dynamic>).toDomain();
  }

  @override
  Future<Provider> getProviderFromId({required String id}) async {
    DocumentSnapshot doc = await providersCollection.doc(id).get();
    if (!doc.exists) {
      throw "Provider does not exist anymore";
    }
    return ProviderJson.fromJson(doc.data() as Map<String, dynamic>).toDomain();
  }

  @override
  Future<List<Provider>> getMatchingProviders({required String input}) async {
    try {
      logger.log("GETTING MATCHING PROVIDERS FOR NAME: ${input}");
      // Fetch all providers where the first letter or a pattern match is found.
      QuerySnapshot querySnapshot = await providersCollection
          .where('providerOnboardingInfo.providerDetails.providerNameLocation',
              isGreaterThanOrEqualTo: input)
          .where('providerOnboardingInfo.providerDetails.providerNameLocation',
              isLessThanOrEqualTo: '${input}\uf8ff')
          .get();

      // Filter results for partial matches.

      List<Provider> providers = [];
      for (var doc in querySnapshot.docs) {
        providers.add(ProviderJson.fromJson(doc.data() as Map<String, dynamic>).toDomain());
      }
      logger.log("GOT PROVIDERS: ${providers.length}");
      return providers;
    } catch (e) {
      print('Error fetching providers: $e');
      return [];
    }
  }

  @override
  Future<void> submitCheckIn({required CheckIn checkIn}) async {
    String docId=checkInCollection.doc().id;
    await checkInCollection.doc(docId).set({
      "id":docId,
      "userId":auth.currentUser?.uid,
      "createdAt":FieldValue.serverTimestamp(),
      "updatedAt":FieldValue.serverTimestamp(),
      "checkIn":checkIn.toJson(),
    });
    await usersCollection.doc(auth.currentUser?.uid).update({
      "onboardingInfo.currentNeedsInfo":checkIn.currentNeedsInfo?.toJson()
    });
  }
}
