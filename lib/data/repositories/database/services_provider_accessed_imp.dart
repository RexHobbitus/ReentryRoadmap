import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/service_provider_accessed.dart';
import '../../models/service_provider_accessed.dart'; // Update this import if necessary.

/// This class to retrieve the service Provider Accessed from firebase
class ServiceProviderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceProviderDataModel>> getServiceProvidersAccessed(String userId) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(userId).get();

      final onboardingInfo = docSnapshot.data()?['onboardingInfo'] as Map<String, dynamic>?;

      // Retrieve the serviceProviderAccessed as a Map or List, depending on your Firestore structure.
      final serviceProviderData = onboardingInfo?['serviceProviderAccessed'] as Map<String, dynamic>?;
      // Check if serviceProvider exists and is a List.
      if (serviceProviderData != null && serviceProviderData['serviceProvider'] is List) {
        // Create a list of ServiceProviderDataModel from the List in serviceProvider.
        List<ServiceProviderDataModel> serviceProviders = (serviceProviderData['serviceProvider'] as List)
            .map((provider) => ServiceProviderDataModel.fromJson(provider))
            .toList();

        return serviceProviders; // Return the list of ServiceProviderDataModel.
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load service provider data: $e');
    }
  }
}
