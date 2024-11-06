import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/learn_more/learn_more_initial_params.dart';
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
  AppUserRepository appUserRepository;

  ExploreCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.providerRepository,
    required this.appUserRepository,

  }) : super(ExploreState.initial());

  BuildContext get context => navigator.context;

  onInit(ExploreInitialParams initialParams) {
    debugPrint("Explore init called...");
    _getServices();
    _getCeoInfo();
    _getFeaturedProvidersOurTake();
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

  quizAction(){
    navigator.openSignUp(const SignUpInitialParams());
  }

  learnMoreAction(){
    navigator.openLearnMore(const LearnMoreInitialParams());
  }
  _getCeoInfo(){
    emit(state.copyWith(loadingCeoInfo: true));
    appUserRepository.getCeoInfo().then((val){
      emit(state.copyWith(ceoInfo: val,loadingCeoInfo: false));
    });
  }

  _getFeaturedProvidersOurTake(){
    emit(state.copyWith(loadingOurTakes: true));
    appUserRepository.getFeaturedProvidersOurTake().then((featuredProviders){
      emit(state.copyWith(featuredProvidersOurTake: featuredProviders,loadingOurTakes:false));
    });
  }
}
