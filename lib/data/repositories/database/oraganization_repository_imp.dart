import 'package:reentry_roadmap/data/repositories/database/firebase_collection.dart';
import 'package:reentry_roadmap/domain/entities/organization.dart';
import 'package:reentry_roadmap/domain/repositories/database/organization_repository.dart';

class OrganizationRepositoryImp extends FirebaseCollection implements OrganizationRepository {
  @override
  Future<List<OrganizationData>> getSetViseOrganization({required List<String> organizationSet}) async {
    try {
      List<List<String>> set = [];
      for (var i = 0; i < organizationSet.length; i += 10) {
        int end = (i + 10 < organizationSet.length) ? i + 10 : organizationSet.length;
        set.add(organizationSet.sublist(i, end));
      }
      List<OrganizationData> organizationList = [];
      for (var ids in set) {
        var data = await organization.where("orgId", whereIn: ids).get();
        organizationList = [...organizationList,...data.docs.map((e) => OrganizationData.fromJson(e.data()),)];
      }
      return organizationList;
    } catch (e) {
      throw Exception('Failed to get getSetViseOrganization: $e');
    }
  }
}
