import '../../../../../data/models/organization_json.dart';
import '../../../../../domain/entities/provider.dart';

class OrganizationDetailState {
  final bool loading;
  final OrganizationJson orgData;
  final List<Provider> providerList;

  const OrganizationDetailState({
    required this.loading,
    required this.orgData,
    required this.providerList,
  });

  factory OrganizationDetailState.initial() => OrganizationDetailState(
        loading: false,
        orgData: OrganizationJson(),
        providerList: [],
      );

  OrganizationDetailState copyWith(
          {bool? loading,
          OrganizationJson? orgData,
          List<Provider>? providerList}) =>
      OrganizationDetailState(
        loading: loading ?? this.loading,
        orgData: orgData ?? this.orgData,
        providerList: providerList ?? this.providerList,
      );
}
