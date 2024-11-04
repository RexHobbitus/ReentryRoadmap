import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../domain/stores/user_store.dart';

part 'organization_detail_state.dart';

class OrganizationDetailCubit extends Cubit<OrganizationDetailState> {
  UserStore userStore;

  OrganizationDetailCubit({
    required this.userStore,
  }) : super(OrganizationDetailInitial());
}
