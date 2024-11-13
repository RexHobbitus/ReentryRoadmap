import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';
import 'package:reentry_roadmap/data/models/provider_review_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/provider_onboarding_info.dart';
import '../../../domain/repositories/database/provider_repository.dart';
import 'firebase_collection.dart';

class ProviderRepositoryImp extends FirebaseCollection
    with FirebaseFunctions
    implements ProviderRepository {
  @override
  Future<void> submitAssessment(
      ProviderOnboardingInfo providerOnboardingInfo) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final docRef = providersCollection.doc(user.uid);

      // Getting the current timestamp
      final timestamp = FieldValue.serverTimestamp();

      // Creating the JSON object to be stored
      final userData = {
        'userId': user.uid,
        'email': user.email,
        'createdAt': timestamp,
        'updatedAt': timestamp,
        'status': kPendingStatus,
        'providerOnboardingInfo': providerOnboardingInfo.toJson(),
      };

      await docRef.set(userData,
          SetOptions(merge: true)); // Using merge to update existing document
    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }

  @override
  Future<List<Provider>> getExplorePageServices() async {
    QuerySnapshot querySnapshot =
        await providersCollection.where('status', isEqualTo: "Approved").get();
    return (querySnapshot.docs)
        .map((data) =>
            ProviderJson.fromJson(data.data() as Map<String, dynamic>)
                .toDomain())
        .toList();
  }

  @override
  Future<Provider> getProviderDetail({required String id}) async {
    DocumentSnapshot documentSnapshot = await providersCollection.doc(id).get();
    return ProviderJson.fromJson(
            documentSnapshot.data() as Map<String, dynamic>)
        .toDomain();
  }

  @override
  Future<void> uploadPhotosOfProvider(
      {required String providerId, required List<dynamic> images}) async {
    List<String> urls = await uploadFiles(images);
    await providersCollection.doc(providerId).update({
      "providerOnboardingInfo.providerDetails.photosByOther":
          FieldValue.arrayUnion(urls),
    });
  }

  @override
  Future<List<ProviderReview>> getProviderReviews({required String id}) async {
    QuerySnapshot querySnapshot =
        await providersCollection.doc(id).collection('providerReviews').get();
    return (querySnapshot.docs)
        .map((data) =>
            ProviderReviewJson.fromJson(data.data() as Map<String, dynamic>)
                .toDomain())
        .toList();
  }
}
