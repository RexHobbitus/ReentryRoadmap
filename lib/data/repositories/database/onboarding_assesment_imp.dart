import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reentry_roadmap/domain/repositories/database/onboarding_repository.dart';
import '../../../domain/entities/onboarding_info.dart';
import '../../../domain/entities/app_user.dart';

class AssessmentRepositoryImpl implements OnboardingRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AssessmentRepositoryImpl(this.firestore, this.auth);

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
        'onboardingInfo': [
          {
            'sectionName': 'Personal Details',
            'sectionIndex': 0,
            'personalAnswers': onboardingInfo.personalInfo?.toJson(),
          },
          {
            'sectionName': 'Incarceration Details',
            'sectionIndex': 1,
            'incarcerationAnswers': onboardingInfo.incarcerationInfo?.toJson(),
          },
          {
            'sectionName': 'Current Needs',
            'sectionIndex': 2,
            'currentNeedsAnswers': onboardingInfo.currentNeedsInfo?.toJson(),
          },
          {
            'sectionName': 'Service Provider Accessed',
            'sectionIndex': 3,
            'providers': onboardingInfo.appProvider?.toJson,
          },
        ],
      };

      await docRef.set(userData, SetOptions(merge: true)); // Using merge to update existing document

    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }
}
