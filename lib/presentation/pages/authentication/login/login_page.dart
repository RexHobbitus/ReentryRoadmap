import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'login_cubit.dart';
import 'login_initial_params.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  final LoginCubit cubit;
  final LoginInitialParams initialParams;

  static const path = '/LoginPage';

  const LoginPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  LoginCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: BlocBuilder<LoginCubit, LoginState>(
          bloc: cubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(kScreenHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your login credentials to explore app features.",
                    style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: context.colorScheme.tertiary),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: cubit.txtEmail,
                    label: "Email",
                  ),
                  CustomTextField(
                    controller: cubit.txtPassword,
                    label: "Password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Login",
                    onTap: cubit.loginAction,
                    isLoading: state.loading,
                  )
                ],
              ),
            );
          },
        ));
  }
}
