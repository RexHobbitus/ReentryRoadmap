import 'package:reentry_roadmap/core/enums/review_sorting.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';

import '../../entities/provider_onboarding_info.dart';

abstract class ProviderRepository with FirebaseFunctions{
  Future<void> submitAssessment(ProviderOnboardingInfo providerOnboardingInfo);
  Future<List<Provider>> getExplorePageServices();
  Future<void> uploadPhotosOfProvider({required String providerId,required List<dynamic> images});
  Future<Provider> getProviderDetail({required String id});
  Future<List<ProviderReview>> getProviderReviews({required String id,ReviewSorting sorting=ReviewSorting.newestFirst});


}
