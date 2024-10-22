import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import '../../../domain/repositories/database/provider_repository.dart';
import 'firebase_collection.dart';

class ProviderRepositoryImp extends FirebaseCollection
    implements ProviderRepository {
  @override
  Future<List<Provider>> getExplorePageServices() async {
    QuerySnapshot querySnapshot = await providersCollection.get();
    return (querySnapshot.docs)
        .map((data) =>
            ProviderJson.fromJson(data.data() as Map<String, dynamic>)
                .toDomain())
        .toList();
  }

  @override
  Future<Provider> getProviderDetail({required String id}) async {
    DocumentSnapshot documentSnapshot=await providersCollection.doc(id).get();
    return ProviderJson.fromJson(documentSnapshot.data() as Map<String, dynamic>)
        .toDomain();
  }
}
