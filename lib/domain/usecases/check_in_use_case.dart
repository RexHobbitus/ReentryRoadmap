import 'package:reentry_roadmap/domain/entities/check_in.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/auth_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import '../entities/onboarding_info.dart';
import 'dart:developer' as logger;

class CheckInUseCase {
  final AppUserRepository appUserRepository;
  final AuthRepository authRepository;
  final UserStore userStore;

  CheckInUseCase({
    required this.authRepository,
    required this.appUserRepository,
    required this.userStore,
  });

  Future<void> execute(CheckIn checkIn) async {
    logger.log(checkIn.toJson().toString());
    // await appUserRepository.submitCheckIn(checkIn: checkIn);
    // LoginUser? loginUser = await authRepository.getCurrentUser();
    // userStore.setUser(loginUser!);
  }
}
