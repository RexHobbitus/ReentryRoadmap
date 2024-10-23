import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/domain/repositories/database/onboarding_repository.dart';
import '../../../domain/entities/onboarding_info.dart';

class OnboardingRepositoryImp extends FirebaseCollection implements OnboardingRepository {

  @override
  Future<void> submitAssessment(OnboardingInfo onboardingInfo) async {
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
        'onboardingInfo':onboardingInfo.toJson(),
      };

      await docRef.set(userData, SetOptions(merge: true)); // Using merge to update existing document

    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }
}
