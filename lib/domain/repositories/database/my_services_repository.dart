import 'package:reentry_roadmap/domain/entities/my_service.dart';

abstract class MyServicesRepository {
  Future<List<MyService>> getMyServices({required String userId});
}
