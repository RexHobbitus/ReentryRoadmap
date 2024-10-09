import 'package:reentry_roadmap/presentation/pages/authentication/login/login_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/login/login_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/notification/notification_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/notification/notification_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_navigator.dart';

import '../presentation/pages/splash/splash_cubit.dart';
import '../presentation/pages/splash/splash_navigator.dart';
import 'service_locator.dart';

/*
     ==============================================================
     THIS CLASS WITH REGISTER SCREENS CUBITS AND NAVIGATORS
      -> NAVIGATORS WILL BE USED FOR NAVIGATION TO OTHER SCREEN
      -> CUBIT WILL BE USED FOR EVENT HANDLING OR BUSINESS LOGIC
      -> BOTH ARE REGISTERED IN GET-IT TO KEEP MEMORY OPTIMIZATION AND SERVICE LOCATOR
     ==============================================================
   */

class AppCubits {
  static initialize() async {
    /// splash screen Cubit + navigator
    getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
    getIt.registerSingleton<SplashCubit>(SplashCubit(
      navigator: getIt(),
      checkUserSessionUseCase: getIt(),
    ));

    getIt.registerSingleton<ExploreNavigator>(ExploreNavigator(getIt()));
    getIt.registerSingleton<ExploreCubit>(ExploreCubit(
      navigator: getIt(),
      userStore: getIt(),
      snackBar: getIt(),
    ));
    getIt.registerSingleton<MoreNavigator>(MoreNavigator(getIt()));
    getIt.registerSingleton<MoreCubit>(MoreCubit(
      navigator: getIt(),
    ));
    getIt.registerSingleton<MyServicesNavigator>(MyServicesNavigator(getIt()));
    getIt.registerSingleton<MyServicesCubit>(MyServicesCubit(
      navigator: getIt(),
    ));
    getIt.registerSingleton<ReviewNavigator>(ReviewNavigator(getIt()));
    getIt.registerSingleton<ReviewCubit>(ReviewCubit(
      navigator: getIt(),
    ));
    getIt.registerSingleton<ProfileNavigator>(ProfileNavigator(getIt()));
    getIt.registerSingleton<ProfileCubit>(ProfileCubit(
      navigator: getIt(),
      logoutUseCase: getIt(),
      userStore: getIt(),
    ));

    getIt.registerSingleton<BottomNavNavigator>(BottomNavNavigator(getIt()));
    getIt.registerSingleton<BottomNavCubit>(BottomNavCubit(
      navigator: getIt(),
      userStore: getIt(),
      snackBar: getIt(),
    ));

    getIt.registerSingleton<NotificationNavigator>(
        NotificationNavigator(getIt()));
    getIt.registerSingleton<NotificationCubit>(NotificationCubit(
      navigator: getIt(),
      userStore: getIt(),
      snackBar: getIt(),
    ));

    getIt.registerSingleton<OnboardingNavigator>(OnboardingNavigator(getIt()));
    getIt.registerSingleton<OnboardingCubit>(OnboardingCubit(
      navigator: getIt(),
      onboardingUseCase: getIt(),
      snackBar: getIt(),
    ));
    getIt.registerSingleton<LoginNavigator>(LoginNavigator(getIt()));
    getIt.registerSingleton<LoginCubit>(LoginCubit(
      navigator: getIt(),
      loginUseCase: getIt(),
      snackBar: getIt(),
    ));
    getIt.registerSingleton<SignUpNavigator>(SignUpNavigator(getIt()));
    getIt.registerSingleton<SignUpCubit>(SignUpCubit(
      navigator: getIt(),
      signUpUseCase: getIt(),
      snackBar: getIt(),
    ));


  }
}
