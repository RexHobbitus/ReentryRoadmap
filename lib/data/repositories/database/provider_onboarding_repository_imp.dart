import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_onboarding_repository.dart';
import '../../../domain/entities/onboarding_info.dart';
import 'package:path/path.dart' as path;

class ProviderOnboardingRepositoryImp extends FirebaseCollection
    implements ProviderOnboardingRepository {
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

Future<List<String>> uploadImagesToFirebase(List<dynamic> images) async {
  List<String> downloadUrls = [];

  try {
    for (var image in images) {
      String fileName = _generateFileName(image);
      
      // Check if the image is from the web or mobile
      if (kIsWeb) {
        // Handle for web (Uint8List)
        Uint8List webImage = image as Uint8List;
        Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
        UploadTask uploadTask = storageRef.putData(webImage);
        
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } else {
        // Handle for mobile (File)
        File mobileImage = image as File;
        Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
        UploadTask uploadTask = storageRef.putFile(mobileImage);
        
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    }
  } catch (e) {
    debugPrint('Error uploading image: $e');
    return [];
  }

  return downloadUrls;
}

String _generateFileName(dynamic image) {
  if (kIsWeb) {
    return DateTime.now().millisecondsSinceEpoch.toString() + '.png';  // You can change extension based on type
  } else {
    return path.basename((image as File).path);
  }
}

}
