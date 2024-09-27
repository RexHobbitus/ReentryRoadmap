import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_initial_params.dart';
import 'package:url_strategy/url_strategy.dart';
import '../../presentation/pages/main/bottom_nav/bottom_nav_page.dart';
import '../../presentation/pages/main/explore/explore_page.dart';
import '../../presentation/pages/main/more/more_page.dart';
import '../../presentation/pages/main/my_services/my_services_page.dart';
import '../../presentation/pages/main/profile/profile_page.dart';
import '../../presentation/pages/main/review/review_page.dart';
import '../../presentation/pages/splash/splash_initial_params.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../service_locator/service_locator.dart';
import '../navigation/app_navigator.dart';

class AppRouter {
  static initialize() {
    setPathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  static final router = GoRouter(
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation: BottomNavPage.path,
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
        path: BottomNavPage.path,
        builder: (context, state) {
          return BottomNavPage(
            cubit: getIt(),
            initialParams: const BottomNavInitialParams(),
          );
        },
      ),
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

    ],
  );
}
