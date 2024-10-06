import 'package:get_it/get_it.dart';
import 'package:reentry_roadmap/data/repositories/auth_repo.dart';
import 'package:reentry_roadmap/data/repositories/auth_repo_imp.dart';
import 'package:reentry_roadmap/presentation/auth_bloc.dart';

import 'domain/repositories/database/user_repository.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSource());
}
