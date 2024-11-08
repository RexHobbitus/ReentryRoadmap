import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/enums/user_session_status.dart';
import 'package:reentry_roadmap/core/extensions/string_extension.dart';
import 'package:reentry_roadmap/domain/usecases/login_use_case.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_initial_params.dart';
import 'login_initial_params.dart';
import 'login_state.dart';
import 'login_navigator.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginNavigator navigator;
  AppSnackBar snackBar;
  LoginUseCase loginUseCase;

  LoginCubit({
    required this.navigator,
    required this.snackBar,
    required this.loginUseCase,
  }) : super(LoginState.initial());

  BuildContext get context => navigator.context;

  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  String email = "", password = "";

  bool isProvider = false;

  onInit(LoginInitialParams initialParams) {}

  loginAction() async {
    try {
      _getValuesFromTextFields();
      _isEmpty();
      _isValidEmail();
      emit(state.copyWith(loading: true));
      UserSessionStatus status = await loginUseCase.execute(
        email: email,
        password: password,
        role: isProvider ? "provider" : "user",
      );
      snackBar.show("Logged in successfully", snackBarType: SnackBarType.SUCCESS);
      if (status == UserSessionStatus.userLoggedInWithNoOnboarding) {
        navigator.openOnboarding(const OnboardingInitialParams());
      } else if (status == UserSessionStatus.providerLoggedInWithNoOnboarding) {
        navigator
            .openProviderOnboarding(const ProviderOnboardingInitialParams());
      } else {
        navigator.openExplore(const ExploreInitialParams());
      }
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  _getValuesFromTextFields() {
    email = txtEmail.text.trim();
    password = txtPassword.text;
  }

  _isEmpty() {
    if (email.isEmpty || password.isEmpty) {
      throw "Please fill all fields";
    }
  }

  _isValidEmail() {
    if (!email.isValidEmail()) {
      throw "Please enter valid email addresss.";
    }
  }

  togglePassword(){
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
