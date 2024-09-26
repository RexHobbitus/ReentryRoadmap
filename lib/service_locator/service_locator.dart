import 'package:get_it/get_it.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_auth_repository.dart';
import 'package:reentry_roadmap/data/repositories/database/firebase_database_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/authentication_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/remote_database_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
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
    getIt.registerSingleton<AuthenticationRepository>(FirebaseAuthRepository());
    getIt.registerSingleton<RemoteDatabaseRepository>(FirebaseDatabaseRepository());

    getIt.registerSingleton<UserStore>(UserStore());


    await AppServices.initialize();
    /// all screens cubits + navigator
    await AppCubits.initialize();
  }
}
