import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';

import '../../entities/provider_onboarding_info.dart';

abstract class ProviderRepository with FirebaseFunctions {
  Future<void> submitAssessment(ProviderOnboardingInfo providerOnboardingInfo);

  Future<List<Provider>> getExplorePageServices();

  Future<void> uploadPhotosOfProvider({required String providerId, required List<dynamic> images});

  Future<Provider> getProviderDetail({required String id});

  Future<List<ProviderReview>> getProviderReviews({required String id});

  Future<List<Provider>> getSearchPageServices({
    required List<CategoryData> categories,
    String? particularServiceSelected,
    required List<String> features,
    required List<String> eligibility, required bool showOnlyEligibleProvider, required String searchText, required String locationText, double? long, double? lat, double? maxDistance, double? minDistance,
  });
}
