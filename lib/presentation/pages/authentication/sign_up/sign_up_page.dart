import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import 'sign_up_cubit.dart';
import 'sign_up_initial_params.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  final SignUpCubit cubit;
  final SignUpInitialParams initialParams;

  static const path = '/SignUpPage';

  const SignUpPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  SignUpCubit get cubit => widget.cubit;

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
        body: BlocBuilder<SignUpCubit, SignUpState>(
          bloc: cubit,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onSurface),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please sign up to gain full access and personalized assistance.",
                      style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
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
                    CustomTextField(
                      controller: cubit.txtConfirmPassword,
                      label: "Confirm Password",
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
                      text: "Create account",
                      onTap: cubit.createAccountAction,
                      isLoading: state.loading,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
