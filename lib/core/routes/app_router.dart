import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
import '../../presentation/pages/splash/splash_initial_params.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/pages/welcome/welcome_initial_params.dart';
import '../../presentation/pages/welcome/welcome_page.dart';
import '../../service_locator/service_locator.dart';
import '../navigation/app_navigator.dart';

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
        path: WelcomePage.path,
        builder: (context, state) {
          return WelcomePage(
            cubit: getIt(),
            initialParams: const WelcomeInitialParams(),
          );
        },
      ),

    ],
  );
}
