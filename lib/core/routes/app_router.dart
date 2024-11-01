import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_page.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/account/account_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/settings/settings_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/notification/notification_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_page.dart';
import 'package:url_strategy/url_strategy.dart';
import '../../presentation/pages/authentication/login/login_page.dart';
import '../../presentation/pages/authentication/onboarding/onboarding_page.dart';
import '../../presentation/pages/main/account/account_page.dart';
import '../../presentation/pages/settings/settings_initial_params.dart';
import '../../presentation/pages/main/bottom_nav/bottom_nav_page.dart';
import '../../presentation/pages/main/explore/explore_page.dart';
import '../../presentation/pages/main/more/more_page.dart';
import '../../presentation/pages/main/my_services/my_services_page.dart';
import '../../presentation/pages/main/notification/notification_page.dart';
import '../../presentation/pages/main/profile/profile_page.dart';
import '../../presentation/pages/main/review/review_page.dart';
import '../../presentation/pages/splash/splash_initial_params.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../service_locator/service_locator.dart';
import '../navigation/app_navigator.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static initialize() {
    setPathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  static final router = GoRouter(
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation: SplashPage.path,
    routes: [
      GoRoute(
        path: SplashPage.path,
        builder: (context, state) {
          return SplashPage(
            cubit: getIt(),
            initialParams: const SplashInitialParams(),
          );
        },
      ),
      GoRoute(
        path: LoginPage.path,
        builder: (context, state) {
          return LoginPage(
            cubit: getIt(),
            initialParams: const LoginInitialParams(),
          );
        },
      ),
      GoRoute(
        path: SignUpPage.path,
        builder: (context, state) {
          return SignUpPage(
            cubit: getIt(),
            initialParams: const SignUpInitialParams(),
          );
        },
      ),
      GoRoute(
        path: SplashPage.path,
        builder: (context, state) {
          return SplashPage(
            cubit: getIt(),
            initialParams: const SplashInitialParams(),
          );
        },
      ),

      /// BOTTOM NAV BAR AND THEIR INNER SCREENS
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return BottomNavPage(
              cubit: getIt(),
              initialParams: const BottomNavInitialParams(),
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: ExplorePage.path,
              builder: (context, state) {
                return ExplorePage(
                  cubit: getIt(),
                  initialParams: const ExploreInitialParams(),
                );
              },
            ),
            GoRoute(
              path: MyServicesPage.path,
              builder: (context, state) {
                return MyServicesPage(
                  cubit: getIt(),
                  initialParams: const MyServicesInitialParams(),
                );
              },
            ),
            GoRoute(
              path: ProfilePage.path,
              builder: (context, state) {
                return ProfilePage(
                  cubit: getIt(),
                  initialParams: const ProfileInitialParams(),
                );
              },
            ),
            GoRoute(
              path: ReviewPage.path,
              builder: (context, state) {
                return ReviewPage(
                  cubit: getIt(),
                  initialParams: const ReviewInitialParams(),
                );
              },
            ),
            GoRoute(
              path: MorePage.path,
              builder: (context, state) {
                return MorePage(
                  cubit: getIt(),
                  initialParams: const MoreInitialParams(),
                );
              },
            ),
            GoRoute(
              path: AccountPage.path,
              builder: (context, state) {
                return AccountPage(
                  cubit: getIt(),
                  initialParams: const AccountInitialParams(),
                );
              },
            ),
            GoRoute(
              path: SettingsPage.path,
              builder: (context, state) {
                return SettingsPage(
                  cubit: getIt(),
                  initialParams: const SettingsInitialParams(),
                );
              },
            ),
          ]),

      /// BOTTOM NAV BAR ENDS HERE
      ///

      GoRoute(
        path: NotificationPage.path,
        builder: (context, state) {
          return NotificationPage(
            cubit: getIt(),
            initialParams: const NotificationInitialParams(),
          );
        },
      ),
      GoRoute(
        path: OnboardingPage.path,
        builder: (context, state) {
          return OnboardingPage(
            cubit: getIt(),
            initialParams: const OnboardingInitialParams(),
          );
        },
      ),
      GoRoute(
        path: ProviderOnboardingPage.path,
        builder: (context, state) {
          return ProviderOnboardingPage(
            cubit: getIt(),
            initialParams: const ProviderOnboardingInitialParams(),
          );
        },
      ),
      GoRoute(
        path: CheckInPage.path,
        builder: (context, state) {
          return CheckInPage(
            cubit: getIt(),
            initialParams: const CheckInInitialParams(),
          );
        },
      ),

      GoRoute(
        path: "${ProviderDetailPage.path}/:id",
        builder: (context, state) {
          return ProviderDetailPage(
            cubit: getIt(),
            initialParams: ProviderDetailInitialParams(id: state.pathParameters['id']!),
          );
        },
      ),
    ],
  );
}
