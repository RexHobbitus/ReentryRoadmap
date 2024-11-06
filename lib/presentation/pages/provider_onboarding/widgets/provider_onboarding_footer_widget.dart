// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_text_button.dart';
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
        int _currentStep = state.providerOnboardingSectionIndex + 1;
        bool isLastSkip= _currentStep==cubit.onBoardingSteps.length-4 && cubit.selectedPrograms.isNotEmpty;
        debugPrint("Current step: ${_currentStep} => total steps ${cubit.onBoardingSteps.length}");
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
                      // /// starting from step 1-12
                      // StepProgressIndicator(
                      //   totalSteps: 12,
                      //   currentStep: _currentStep >= 12 ? 12 : _currentStep,
                      //   selectedColor: context.colorScheme.secondary,
                      //   unselectedColor: context.colorScheme.tertiaryContainer,
                      //   size: 5,
                      //   padding: 0,
                      // ),
                      // const SizedBox(
                      //   width: 5,
                      // ),

                      // /// starting step 13-15
                      // StepProgressIndicator(
                      //   totalSteps: 3,
                      //   currentStep: _currentStep - 12 < 0
                      //       ? 0
                      //       : (_currentStep - 12) > 3
                      //           ? 3
                      //           : (_currentStep - 12),
                      //   selectedColor: context.colorScheme.secondary,
                      //   unselectedColor: context.colorScheme.tertiaryContainer,
                      //   size: 5,
                      //   padding: 0,
                      // ),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                      // //// starting from step 16
                      // StepProgressIndicator(
                      //   totalSteps: 6,
                      //   currentStep: _currentStep - 12 < 0
                      //       ? 0
                      //       : (_currentStep - 19) > 17
                      //           ? 17
                      //           : (_currentStep - 19),
                      //   selectedColor: context.colorScheme.secondary,
                      //   unselectedColor: context.colorScheme.tertiaryContainer,
                      //   size: 5,
                      //   padding: 0,
                      // ),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                      // StepProgressIndicator(
                      //   totalSteps: 5,
                      //   currentStep:
                      //       _currentStep - 33 < 0 ? 0 : _currentStep - 33,
                      //   selectedColor: context.colorScheme.secondary,
                      //   unselectedColor: context.colorScheme.tertiaryContainer,
                      //   size: 5,
                      //   padding: 0,
                      // ),
                      // First Progress Indicator - 12 Steps
                      StepProgressIndicator(
                        totalSteps: 12,
                        currentStep: _currentStep >= 12 ? 12 : _currentStep,
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),

// Second Progress Indicator - 3 Steps
                      StepProgressIndicator(
                        totalSteps: 3,
                        currentStep: _currentStep - 12 < 0
                            ? 0
                            : (_currentStep - 12) > 3
                                ? 3
                                : (_currentStep - 12),
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),

// Third Progress Indicator - 6 Steps (should handle 6 total steps)
                      StepProgressIndicator(
                        totalSteps: 6,
                        currentStep: _currentStep - 15 < 0
                            ? 0
                            : (_currentStep - 15) > 6
                                ? 6
                                : (_currentStep - 15),
                        selectedColor: context.colorScheme.secondary,
                        unselectedColor: context.colorScheme.tertiaryContainer,
                        size: 5,
                        padding: 0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),

// Fourth Progress Indicator - 5 Steps
                      StepProgressIndicator(
                        totalSteps: 5,
                        currentStep: _currentStep - 21 < 0
                            ? 0
                            : (_currentStep - 21) > 5
                                ? 5
                                : (_currentStep - 21),
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
                      _currentStep>1?
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
                        ):const SizedBox.shrink(),
                      Row(
                        children: [
                          if (_currentStep == 3 ||
                              _currentStep == 7 ||
                              _currentStep == 10 ||
                              _currentStep == 11 ||
                              (_currentStep==cubit.onBoardingSteps.length-4 && cubit.selectedPrograms.isNotEmpty)
                          )
                            CustomTextButton(
                              text: "Skip Question",
                              onTap: isLastSkip?cubit.submitOnboardingInfo:
                              cubit.nextStepAction,
                            ),
                          if (_currentStep > 1)
                            SizedBox(
                              width: 20,
                            ),
                          ValueListenableBuilder(
                            valueListenable:cubit.isNextButtonEnabled,
                            builder: (context,value,child) {
                              return CustomButton(
                                text: cubit.isProviderOnboardingCompleted()
                                    ? "Finish Provider Onboarding"
                                    : "Next",
                                isLoading: state.loading,
                                width: device == DeviceSize.mobile
                                    ? cubit.isProviderOnboardingCompleted()
                                        ? 200
                                        : 90
                                    : cubit.isProviderOnboardingCompleted()
                                        ? 300
                                        : 120,
                                height: device == DeviceSize.mobile ? 35 : 55,
                                iconData:
                                    cubit.isProviderOnboardingCompleted()
                                        ? null
                                        : Icons.arrow_forward,
                                isDisabled: !value,
                                onTap: cubit.nextStepAction,
                              );
                            }
                          ),
                        ],
                      )
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
