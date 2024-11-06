
import 'package:reentry_roadmap/domain/entities/organization.dart';

abstract class OrganizationRepository  {
  Future<List<OrganizationData>> getSetViseOrganization({required List<String> organizationSet});
}
