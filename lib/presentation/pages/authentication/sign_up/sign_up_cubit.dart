import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/extensions/string_extension.dart';
import 'package:reentry_roadmap/domain/usecases/sign_up_use_case.dart';
import '../onboarding/onboarding_initial_params.dart';
import 'sign_up_initial_params.dart';
import 'sign_up_state.dart';
import 'sign_up_navigator.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpNavigator navigator;
  AppSnackBar snackBar;
  SignUpUseCase signUpUseCase;

  SignUpCubit({
    required this.navigator,
    required this.snackBar,
    required this.signUpUseCase,
  }) : super(SignUpState.initial());

  BuildContext get context => navigator.context;

  onInit(SignUpInitialParams initialParams) {}

  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();


  String email = "", password = "",confirmPassword="";

  createAccountAction() async {
    try {
      _getValuesFromTextFields();
      _isEmpty();
      _isValidEmail();
      _isPasswordMatches();
      emit(state.copyWith(loading: true));
      await signUpUseCase.execute(email: email, password: password);
      navigator.openOnboarding(const OnboardingInitialParams());
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  _getValuesFromTextFields() {
    email = txtEmail.text.trim();
    password = txtPassword.text;
    confirmPassword=txtConfirmPassword.text;
  }

  _isEmpty() {
    if (email.isEmpty || password.isEmpty) {
      throw "Please fill all fields";
    }
  }
  _isPasswordMatches() {
    if (password!=confirmPassword) {
      throw "Password does not matches";
    }
  }


  _isValidEmail() {
    if (!email.isValidEmail()) {
      throw "Please enter valid email address.";
    }
  }
}
