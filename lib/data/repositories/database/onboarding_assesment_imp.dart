import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reentry_roadmap/domain/repositories/database/onboarding_repository.dart';

import '../../../domain/entities/onboarding_info.dart';

class AssessmentRepositoryImpl implements OnboardingRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AssessmentRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> submitAssessment(
      OnboardingInfo onboardingInfo) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final docRef = firestore.collection('users').doc(user.uid);
      await docRef.set({
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        "onboardingInfo":onboardingInfo.toJson(),
      });
    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }
}
