import 'package:reentry_roadmap/data/models/my_service_json.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/domain/repositories/database/my_services_repository.dart';

 class MyServicesRepositoryImp extends FirebaseCollection
    implements MyServicesRepository {
  final String _myServicesSubCollection = "myServices";

  @override
  Future<List<MyService>> getMyServices({required String userId}) async {
    final result = await usersCollection
        .doc(userId)
        .collection(_myServicesSubCollection)
        .get();

    if (result.docs.isNotEmpty) {
      List<MyService> myServices = [];

      for (var element in result.docs) {

        myServices.add(MyServiceJson.fromJson(element.data()).toDomain());
      }

      return myServices;
    } else {
      return [];
    }
  }

  @override
  Future<void> updateActiveServiceStatus({required String userId,required String serviceId,required Map<String, dynamic> data}) async {

     await usersCollection
        .doc(userId)
        .collection(_myServicesSubCollection).doc(serviceId).update(data);



  }
}
