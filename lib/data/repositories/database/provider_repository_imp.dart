import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';
import 'package:reentry_roadmap/data/models/provider_review_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/entities/provider_onboarding_info.dart';
import '../../../domain/repositories/database/provider_repository.dart';
import 'firebase_collection.dart';

class ProviderRepositoryImp extends FirebaseCollection with FirebaseFunctions implements ProviderRepository {
  @override
  Future<void> submitAssessment(ProviderOnboardingInfo providerOnboardingInfo) async {
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

      await docRef.set(userData, SetOptions(merge: true)); // Using merge to update existing document
    } catch (e) {
      throw Exception('Failed to save answers: $e');
    }
  }

  @override
  Future<List<Provider>> getExplorePageServices() async {
    QuerySnapshot querySnapshot = await providersCollection.where('status', isEqualTo: "Approved").get();
    return (querySnapshot.docs).map((data) => ProviderJson.fromJson(data.data() as Map<String, dynamic>).toDomain()).toList();
  }

  @override
  Future<Provider> getProviderDetail({required String id}) async {
    DocumentSnapshot documentSnapshot = await providersCollection.doc(id).get();
    return ProviderJson.fromJson(documentSnapshot.data() as Map<String, dynamic>).toDomain();
  }

  @override
  Future<void> uploadPhotosOfProvider({required String providerId, required List<dynamic> images}) async {
    List<String> urls = await uploadFiles(images);
    await providersCollection.doc(providerId).update({
      "providerOnboardingInfo.providerDetails.photosByOther": FieldValue.arrayUnion(urls),
    });
  }

  @override
  Future<List<ProviderReview>> getProviderReviews({required String id}) async {
    QuerySnapshot querySnapshot = await providersCollection.doc(id).collection('reviews').get();
    return (querySnapshot.docs).map((data) => ProviderReviewJson.fromJson(data.data() as Map<String, dynamic>).toDomain()).toList();
  }

  @override
  Future<List<Provider>> getSearchPageServices({
    required List<CategoryData> categories,
    String? particularServiceSelected,
    required List<String> features,
    required List<String> eligibility,
    required bool showOnlyEligibleProvider,
    required String searchText,
    required String locationText,
    double? long,
    double? lat,
    double? maxDistance,
    double? minDistance,
  }) async {
    print("particularServiceSelected===>$particularServiceSelected");
    QuerySnapshot querySnapshot = await providersCollection.get();
    List<Provider> result = (querySnapshot.docs).map((data) => ProviderJson.fromJson(data.data() as Map<String, dynamic>).toDomain()).toList();
    List<CategoryData> selectedCategories = categories.where((element) => element.isSelected ?? false).toList();

    if (selectedCategories.isEmpty &&
        (particularServiceSelected?.isEmpty ?? false) &&
        features.isEmpty &&
        eligibility.isEmpty &&
        showOnlyEligibleProvider == false &&
        searchText.isEmpty &&
        locationText.isEmpty &&
        maxDistance == null &&
        minDistance == null) {
      return result;
    }
    List<Provider> toReturn = [];
    if (particularServiceSelected?.isNotEmpty ?? false) {
      for (final service in result) {
        final serviceCategories = service.getAllCategories();
        print("serviceCategories===>$serviceCategories of ${service.onboardingInfo?.providerDetails?.providerNameLocation}");
        if (serviceCategories.contains(particularServiceSelected)) {
          toReturn.add(service);
        }
      }
      // return toReturn;
    }
    print("toReturn11===>${toReturn.length}");

    List<String> selectedSubCategories = [];
    categories.where((element) => element.isSelected ?? false).forEach(
      (category) {
        selectedSubCategories.addAll(category.subCategories?.where((element) => element.isSelected).map((e) => e.title).toList() ?? []);
      },
    );
    if (selectedCategories.isNotEmpty) {
      for (final service in result) {
        final serviceCategories = service.getAllCategories();
        print("serviceCategories===>$serviceCategories of ${service.onboardingInfo?.providerDetails?.providerNameLocation}");
        for (var category in selectedCategories) {
          if (serviceCategories?.contains(category.title) ?? false) {
            final selectedSubCategory = category.subCategories?.where((element) => element.isSelected).toList();
            if (selectedSubCategory?.isNotEmpty ?? false) {
              List<String> serviceCategories = [];
              service.onboardingInfo?.generalService?.serviceCategories?.forEach((element) {
                serviceCategories.addAll(element.subCategories ?? []);
              });
              for (final subCategory in selectedSubCategories) {
                if (serviceCategories.contains(subCategory)) {
                  toReturn.add(service);
                }
              }
            } else {
              toReturn.add(service);
            }
          }
        }
      }
    }

    print("toReturn11===>${toReturn.length}");

    // reorder features and eligibility
    List<Provider> tempReturn = [];
    for (var service in toReturn) {
      var programList = service.onboardingInfo?.programs ?? [];
      List<Program> tempProgramList = [];
      for (var program in programList) {
        // reorder features
        var programFeatures = program.features ?? [];
        var selectedFeatures = programFeatures
            .where(
              (element) => features.contains(element),
            )
            .toList();
        var unselectedFeatures = programFeatures
            .where(
              (element) => !features.contains(element),
            )
            .toList();
        programFeatures = [...selectedFeatures, ...unselectedFeatures];

        // reorder eligibility
        var programEligibility = program.eligibilityCriteria ?? [];
        var selectedEligibility = programEligibility
            .where(
              (element) => eligibility.contains(element),
            )
            .toList();

        var unselectedEligibility = programEligibility
            .where(
              (element) => !eligibility.contains(element),
            )
            .toList();
        programEligibility = [...selectedEligibility, ...unselectedEligibility];
        tempProgramList.add(program.copyWith(
            features: programFeatures,
            eligibilityCriteria: programEligibility,
            eligibilityRatio: selectedEligibility.isEmpty || programEligibility.isEmpty ? 0 : eligibility.length / programEligibility.length * 100));
      }

      tempReturn.add(service.copyWith(
          onboardingInfo: service.onboardingInfo?.copyWith(
              programs: [...tempProgramList]..sort(
                  (a, b) => (b.eligibilityRatio ?? 0).compareTo(a.eligibilityRatio ?? 0),
                ))));
    }
    // filter provider with 100% or more then eligibilityRatio
    if (showOnlyEligibleProvider) {
      List<Provider> eligibleFilterList = [];
      for (var service in tempReturn) {
        final list = service.onboardingInfo?.programs
            ?.where(
              (e) => (e.eligibilityRatio ?? 0) >= 100,
            )
            .toList();

        if (list?.isNotEmpty ?? false) {
          eligibleFilterList.add(service);
        }
      }
      tempReturn = eligibleFilterList;
    }
    toReturn = tempReturn;
    // apply search query
    if (searchText.isNotEmpty) {
      toReturn = toReturn.where(
        (element) {
          final text = element.onboardingInfo?.providerDetails?.providerNameLocation?.toLowerCase();
          return StringSimilarity.compareTwoStrings(text, searchText.toLowerCase()) > 0.5;
        },
      ).toList();
    }

    // apply location query
    if (locationText.isNotEmpty) {
      toReturn = toReturn.where(
        (element) {
          return element.completeAddress.toLowerCase().contains(locationText.toLowerCase());
        },
      ).toList();
    }

    //apple distance filter
    if (!([
      lat,
      long,
    ].contains(null))) {
      if (maxDistance != null || minDistance != null) {
        List<Provider> tempList = [];
        for (Provider service in toReturn) {
          if (service.onboardingInfo?.providerDetails?.gpsLocation != null) {
            final meters = Geolocator.distanceBetween(lat!, long!, service.onboardingInfo!.providerDetails!.gpsLocation!.latitude,
                service.onboardingInfo!.providerDetails!.gpsLocation!.longitude);
            final miles = metersToMiles(meters);
            if (![minDistance, maxDistance].contains(null)) {
              if (miles > minDistance! && miles < maxDistance!) {
                tempList.add(service);
              }
            } else if (minDistance != null) {
              if (miles > minDistance) {
                tempList.add(service);
              }
            } else if (maxDistance != null) {
              if (miles < maxDistance) {
                tempList.add(service);
              }
            }
          }
        }
        toReturn = tempList;
      }
    }
    return toReturn.toSet().toList();
  }
}

double metersToMiles(double meters) {
  return meters * 0.000621371;
}
