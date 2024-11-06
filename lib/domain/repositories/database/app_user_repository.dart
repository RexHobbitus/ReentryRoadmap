
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/ceo_info.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';

import '../../entities/check_in.dart';
import '../../entities/onboarding_info.dart';

abstract class AppUserRepository {
  Future<void> submitAssessment(OnboardingInfo onboardingInfo);
  Future<void> submitCheckIn({required CheckIn checkIn});
  Future<void> giveReviewToProvider({required String providerId,required ProviderReview review});
  Future<AppUser> getUserFromId({required String id});
  Future<Provider> getProviderFromId({required String id});
  Future<List<Provider>> getMatchingProviders({required String input});
  Future<CeoInfo> getCeoInfo();
}
