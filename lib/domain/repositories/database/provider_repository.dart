import 'package:reentry_roadmap/domain/entities/provider.dart';

abstract class ProviderRepository{
  Future<List<Provider>> getExplorePageServices();
  Future<Provider> getProviderDetail({required String id});

}