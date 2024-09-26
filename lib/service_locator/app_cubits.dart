
import '../presentation/pages/splash/splash_cubit.dart';
import '../presentation/pages/splash/splash_initial_params.dart';
import '../presentation/pages/splash/splash_navigator.dart';
import '../presentation/pages/welcome/welcome_cubit.dart';
import '../presentation/pages/welcome/welcome_navigator.dart';
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
    ));

    /// welcome screen Cubit + navigator
    getIt.registerSingleton<WelcomeNavigator>(WelcomeNavigator(getIt()));
    getIt.registerSingleton<WelcomeCubit>(WelcomeCubit(
      navigator: getIt(),
    ));
  }
}
