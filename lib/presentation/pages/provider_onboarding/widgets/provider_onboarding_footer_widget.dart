import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_state.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProviderOnboardingFooterWidget extends StatelessWidget {
  final ProviderOnboardingCubit cubit;

  const ProviderOnboardingFooterWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderOnboardingCubit, ProviderOnboardingState>(
      bloc: cubit,
      builder: (context, state) {
        int _currentStep = 0;
        //state.onboardingSectionIndex + 1;
        debugPrint("Current step: ${_currentStep}");
        return CustomResponsiveBuilder(builder: (context, constraints, device) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: device == DeviceSize.mobile ? 0 : 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Row(
                    children: [
                      /// starting from step 1-8
                      StepProgressIndicator(
                        totalSteps: 8,
                        currentStep: _currentStep >= 8 ? 8 : _currentStep,
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                      /// starting step 9-18
                      StepProgressIndicator(
                        totalSteps: 11,
                        currentStep: _currentStep - 8 < 0
                            ? 0
                            : (_currentStep - 8) > 11
                                ? 11
                                : (_currentStep - 8),
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //// starting from step 19
                      StepProgressIndicator(
                        totalSteps: 14,
                        currentStep: _currentStep - 19 < 0
                            ? 0
                            : (_currentStep - 19) > 14
                                ? 14
                                : (_currentStep - 19),
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      StepProgressIndicator(
                        totalSteps: 3,
                        currentStep:
                            _currentStep - 33 < 0 ? 0 : _currentStep - 33,
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kScreenHorizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        iconAlignment: IconAlignment.start,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 15,
                          color: context.colorScheme.onSurface,
                        ),
                        label: Text(
                          "Back",
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: cubit.backAction,
                      ),
                      CustomButton(
                        text: "Next",
                        isLoading: state.loading,
                        width: 150,
                        height: device == DeviceSize.mobile ? 35 : 55,
                        iconData: Icons.arrow_forward,
                        onTap: cubit.nextStepAction,
                      ) //     })
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
