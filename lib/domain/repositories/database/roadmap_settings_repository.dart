
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_functions.dart';

abstract class RoadmapSettingsRepository with FirebaseFunctions {
  Future<List<CategoryData>> getCategories();

  Future<List<String>> getEligibilities();

  Future<List<String>> getFeatures();
}
