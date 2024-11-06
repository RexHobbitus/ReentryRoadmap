import 'package:get_it/get_it.dart';
import 'package:reentry_roadmap/data/repositories/database/app_user_repository_imp.dart';
import 'package:reentry_roadmap/data/repositories/database/auth_repository_imp.dart';
import 'package:reentry_roadmap/data/repositories/database/provider_repository_imp.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/domain/usecases/change_password_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/check_in_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/check_user_session_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/login_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/logout_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/onboarding_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/provider_onboarding_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/sign_up_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/update_data_sharing_settings_use_case.dart';
import 'package:reentry_roadmap/domain/usecases/update_user_profile_info_use_case.dart';
import '../core/alert/app_snack_bar.dart';
import '../core/navigation/app_navigator.dart';
import '../data/repositories/database/hive_database_repository.dart';
import '../domain/repositories/database/local_database_repository.dart';
import '../network/dio/dio_network_repository.dart';
import '../network/network_repository.dart';
import 'app_cubits.dart';
import 'app_services.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static initialize() async {
    getIt.registerSingleton<AppSnackBar>(AppSnackBar());
    getIt.registerSingleton<AppNavigator>(AppNavigator());

    /// local storage
    getIt.registerSingleton<LocalDatabaseRepository>(HiveDatabaseRepository()).initialize();

    /// http request repository
    getIt.registerSingleton<NetworkRepository>(DioNetworkRepository(getIt()));
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImp());
    getIt.registerSingleton<AppUserRepository>(AppUserRepositoryImp());
    getIt.registerSingleton<ProviderRepository>(ProviderRepositoryImp());

    getIt.registerSingleton<UserStore>(UserStore());

    /// use cases
    ///
    getIt.registerSingleton<CheckUserSessionUseCase>(CheckUserSessionUseCase(
      authRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<OnboardingUseCase>(OnboardingUseCase(
      authRepository: getIt(),
      appUserRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<ProviderOnboardingUseCase>(ProviderOnboardingUseCase(
      authRepository: getIt(),
      providerRepository: getIt(),
      userStore: getIt(),
    ));

    getIt.registerSingleton<LoginUseCase>(LoginUseCase(
      authRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<SignUpUseCase>(SignUpUseCase(
      authRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(
      authRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<CheckInUseCase>(CheckInUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      appUserRepository: getIt(),
    ));
    getIt.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(
      authRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<UpdateDataSharingSettingsUseCase>(UpdateDataSharingSettingsUseCase(
      appUserRepository: getIt(),
      authRepository: getIt(),
      userStore: getIt(),
    ));
    getIt.registerSingleton<UpdateUserProfileInfoUseCase>(UpdateUserProfileInfoUseCase(
      appUserRepository: getIt(),
      authRepository: getIt(),
      userStore: getIt(),
    ));

    await AppServices.initialize();

    /// all screens cubits + navigator
    await AppCubits.initialize();
  }
}
