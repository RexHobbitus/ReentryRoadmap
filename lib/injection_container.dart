import 'package:get_it/get_it.dart';
import 'package:reentry_roadmap/data/repositories/auth_repo.dart';
import 'package:reentry_roadmap/data/repositories/auth_repo_imp.dart';
import 'package:reentry_roadmap/domain/repositories/user_repository.dart';
import 'package:reentry_roadmap/presentation/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => AuthCubit(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()));

  // Data source
  sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSource());
}
