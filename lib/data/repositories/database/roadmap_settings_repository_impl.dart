import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';
import 'package:reentry_roadmap/domain/repositories/database/roadmap_settings_repository.dart';

class RoadmapSettingsRepositoryImpl extends FirebaseCollection with FirebaseFunctions implements RoadmapSettingsRepository {
  @override
  Future<List<CategoryData>> getCategories() async {
    // try {
    final data = await roadmapSettingsCollection.doc("categories").get();
    final categories = data.data()?['categories'] as List<dynamic>;
    return categories.map((e) => CategoryData.fromJson(e)).toList();
    // } catch (e) {
    //   return [];
    // }
  }

  @override
  Future<List<String>> getEligibilities() async {
    try {
      final data = await roadmapSettingsCollection.doc("eligibilities").get();
      final eligibilities = data.data()?['eligibilities'] as List<dynamic>;
      return eligibilities.map((e) => e.toString()).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<String>> getFeatures() async {
    try {
      final data = await roadmapSettingsCollection.doc("features").get();
      final features = data.data()?['features'] as List<dynamic>;
      return features.map((e) => e.toString()).toList();
    } catch (_) {
      return [];
    }
  }
}
