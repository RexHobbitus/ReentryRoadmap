import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/header_auth_buttons.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
import 'onboarding_cubit.dart';
import 'onboarding_initial_params.dart';
import 'onboarding_state.dart';
import 'steps/personal_details/personal_details_intro.dart';
import 'steps/personal_details/personal_details_name_section.dart';
import 'widgets/onboarding_footer.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingCubit cubit;
  final OnboardingInitialParams initialParams;

  static const path = '/OnboardingPage';

  const OnboardingPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingPage> {
  OnboardingCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (val,data){
        cubit.backAction();
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          leading: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderLogo(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kScreenHorizontalPadding),
                  child: HeaderAuthButtons(
                    loginAction: () {},
                    isMobileView: constraints.maxWidth <= kMenuBreakPoint,
                  ),
                ),
              ],
            );
          }),
        ),
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          bloc: cubit,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                child: cubit.onBoardingSteps[state.onboardingSectionIndex],
              ),
            );
          },
        ),
        bottomNavigationBar: OnboardingFooter(
          cubit: cubit,
        ),
      ),
    );
  }
}
