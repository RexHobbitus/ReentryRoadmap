import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/enums/user_session_status.dart';
import 'package:reentry_roadmap/domain/usecases/check_user_session_use_case.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_initial_params.dart';
import 'splash_initial_params.dart';
import 'splash_state.dart';
import 'splash_navigator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashNavigator navigator;
  CheckUserSessionUseCase checkUserSessionUseCase;

  SplashCubit({
    required this.navigator,
    required this.checkUserSessionUseCase,
  }) : super(SplashState.initial());

  BuildContext get context => navigator.context;

  onInit(SplashInitialParams initialParams) {
    _navigateToBottomNav();
  }

  _navigateToBottomNav() async {
    await checkUserSessionUseCase.execute().then((status) {
      if (status == UserSessionStatus.userLoggedInWithNoOnboarding) {
        navigator.openOnboarding(const OnboardingInitialParams());
      }
      if (status == UserSessionStatus.providerLoggedInWithNoOnboarding) {
        navigator.openProviderOnboarding(const ProviderOnboardingInitialParams());
      } else {
        navigator.openExplore(const ExploreInitialParams());
      }
    });
  }
}
