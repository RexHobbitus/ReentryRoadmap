import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/domain/usecases/logout_use_case.dart';
import 'profile_initial_params.dart';
import 'profile_state.dart';
import 'profile_navigator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileNavigator navigator;
  UserStore userStore;
  LogoutUseCase logoutUseCase;
  ProfileCubit({
    required this.navigator,
    required this.userStore,
    required this.logoutUseCase,
  }) : super(ProfileState.initial());

  BuildContext get context => navigator.context;

  onInit(ProfileInitialParams initialParams) {}

  logoutAction() async {
    await logoutUseCase.execute();
  }
}
