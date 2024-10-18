import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_onboarding_repository.dart';
import '../../../domain/entities/onboarding_info.dart';

class ProviderOnboardingRepositoryImp extends FirebaseCollection
    implements ProviderOnboardingRepository {
  @override
  Future<void> submitAssessment(
      ProviderOnboardingInfo providerOnboardingInfo) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final docRef = firestore.collection('users').doc(user.uid);

      // Getting the current timestamp
      final timestamp = FieldValue.serverTimestamp();

      // Creating the JSON object to be stored
      final userData = {
        'userId': user.uid,
        'email': user.email,
        'createdAt': timestamp,
        'updatedAt': timestamp,
        'status': kPendingStatus,
        'onboardingInfo': providerOnboardingInfo.toJson(),
      };

      await docRef.set(userData,
          SetOptions(merge: true)); // Using merge to update existing document
    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }
}
