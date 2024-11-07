import 'package:reentry_roadmap/domain/entities/my_service.dart';

abstract class MyServicesRepository {
  Future<List<MyService>> getMyServices({required String userId});

  Future<void> updateActiveServiceStatus({required String userId,required String serviceId,required Map<String,dynamic> data});
}
