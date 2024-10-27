import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_initial_params.dart';
import '../../../../domain/entities/provider.dart';
import 'explore_initial_params.dart';
import 'explore_state.dart';
import 'explore_navigator.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;
  ProviderRepository providerRepository;

  ExploreCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.providerRepository,
  }) : super(ExploreState.initial());

  BuildContext get context => navigator.context;

  onInit(ExploreInitialParams initialParams) {
    debugPrint("Explore init called...");
    _getServices();
  }

  openProviderDetail(Provider provider) {
    navigator
        .openProviderDetail(ProviderDetailInitialParams(id: provider.userId!));
  }

  _getServices() async {
    try {
      emit(state.copyWith(loading: state.services.isEmpty));
      List<Provider> services =
          await providerRepository.getExplorePageServices();
      emit(state.copyWith(services: services));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  checkInAction() {
    navigator.openCheckIn(const CheckInInitialParams());
  }

  categoryAction(ServiceCategory category) {
    snackBar.show(
        "TODO: Navigate to Search screen => ${category.title} results",
        snackBarType: SnackBarType.INFO);
  }
}
