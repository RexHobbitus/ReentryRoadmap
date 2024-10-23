import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

import '../../entities/provider_onboarding_info.dart';

abstract class ProviderRepository with FirebaseFunctions{
  Future<void> submitAssessment(ProviderOnboardingInfo providerOnboardingInfo);

  Future<List<Provider>> getExplorePageServices();

  Future<Provider> getProviderDetail({required String id});

}
