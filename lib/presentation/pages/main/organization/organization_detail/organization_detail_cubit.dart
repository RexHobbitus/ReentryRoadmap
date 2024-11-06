import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/pages/main/organization/organization_detail/organization_detail_initial_params.dart';

import '../../../../../data/models/organization_json.dart';
import '../../../../../data/models/provider_json.dart';
import '../../../../../domain/stores/user_store.dart';
import 'organization_detail_state.dart';

class OrganizationDetailCubit extends Cubit<OrganizationDetailState> {
  UserStore userStore;

  OrganizationDetailCubit({
    required this.userStore,
  }) : super(OrganizationDetailState.initial());

  onInit(OrganizationDetailInitialParams initialParams) async {
    String orgId = initialParams.id;
    DocumentSnapshot orgData = await FirebaseFirestore.instance
        .collection('organization')
        .doc(orgId)
        .get();

    OrganizationJson organizationJson =
        OrganizationJson.fromJson(orgData.data() as Map<String, dynamic>);

    QuerySnapshot providerData = await FirebaseFirestore.instance
        .collection('providers')
        .where("orgId", isEqualTo: orgId)
        .get();

    List<Provider> tmoProviderList = providerData.docs
        .map((data) =>
            ProviderJson.fromJson(data.data() as Map<String, dynamic>)
                .toDomain())
        .toList();

    emit(state.copyWith(
        orgData: organizationJson, providerList: tmoProviderList));
  }
}
