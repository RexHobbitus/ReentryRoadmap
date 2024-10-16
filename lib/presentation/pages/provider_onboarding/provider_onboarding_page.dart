import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_state.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_footer_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/header_auth_buttons.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
import 'provider_onboarding_cubit.dart';
import 'provider_onboarding_initial_params.dart';

class ProviderOnboardingPage extends StatefulWidget {
  final ProviderOnboardingCubit cubit;
  final ProviderOnboardingInitialParams initialParams;

  static const path = '/ProviderOnboardingPage';
  const ProviderOnboardingPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ProviderOnboardingPage> createState() => _ProviderOnboardingState();
}

class _ProviderOnboardingState extends State<ProviderOnboardingPage> {
  ProviderOnboardingCubit get cubit => widget.cubit;

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
      body: BlocBuilder<ProviderOnboardingCubit, ProviderOnboardingState>(
        bloc: cubit,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kScreenHorizontalPadding),
              child:
                  cubit.onBoardingSteps[state.providerOnboardingSectionIndex],
            ),
          );
        },
      ),
      bottomNavigationBar: ProviderOnboardingFooterWidget(
        cubit: cubit,
      ),
    );
  }
}
