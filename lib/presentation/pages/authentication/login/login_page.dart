import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          leading: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const HeaderLogo(),
              ],
            );
          }),
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
                    "Log In",
                    style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: context.colorScheme.onSurface),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please log in to gain full access and personalized assistance.",
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
                  CustomCheckBox(
                    text: "Create account as Provider",
                    value: cubit.isProvider,
                    onChange: (val) {
                      cubit.isProvider = val;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Log In",
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
