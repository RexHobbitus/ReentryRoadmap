// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
// import 'package:reentry_roadmap/core/utils/constants.dart';
// import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
// import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_state.dart';
// import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
// import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
// import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
// import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

// class CheckInFooter extends StatelessWidget {
//   final CheckInCubit cubit;

//   const CheckInFooter({
//     super.key,
//     required this.cubit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CheckInCubit, CheckInState>(
//       bloc: cubit,
//       builder: (context, state) {
//         int _currentStep = state.checkInSectionIndex + 1;
//         debugPrint("Current step: ${_currentStep}");
//         return CustomResponsiveBuilder(builder: (context, constraints, device) {
//           return Padding(
//             padding:
//                 EdgeInsets.only(bottom: device == DeviceSize.mobile ? 0 : 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 FittedBox(
//                   child: Row(
//                     children: [
//                       StepProgressIndicator(
//                         totalSteps: 14,
//                         currentStep: _currentStep >= 14 ? 14 : _currentStep,
//                         selectedColor: context.colorScheme.secondary,
//                         unselectedColor: context.colorScheme.tertiaryContainer,
//                         size: 5,
//                         padding: 0,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: kScreenHorizontalPadding),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton.icon(
//                         iconAlignment: IconAlignment.start,
//                         icon: Icon(
//                           Icons.arrow_back,
//                           size: 15,
//                           color: context.colorScheme.onSurface,
//                         ),
//                         label: Text(
//                           "Back",
//                           style: context.textTheme.bodyMedium?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               decoration: TextDecoration.underline),
//                         ),
//                         onPressed: cubit.backAction,
//                       ),
//                       StreamBuilder<bool>(
//                           stream: cubit.textFieldUpdateListener.stream,
//                           builder: (context, data) {
//                             return CustomButton(
//                               text: cubit.isOnboardingCompleted()
//                                   ? "Complete Onboarding"
//                                   : "Next",
//                               isLoading: state.loading,
//                               width: device == DeviceSize.mobile
//                                   ? cubit.isOnboardingCompleted()
//                                       ? 200
//                                       : 90
//                                   : cubit.isOnboardingCompleted()
//                                       ? 300
//                                       : 120,
//                               height: device == DeviceSize.mobile ? 35 : 55,
//                               iconData: cubit.isOnboardingCompleted()
//                                   ? null
//                                   : Icons.arrow_forward,
//                               isDisabled: !cubit.isNextButtonEnabled(),
//                               onTap: cubit.nextStepAction,
//                             );
//                           })
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class CheckInFooter extends StatelessWidget {
  final CheckInCubit cubit;

  const CheckInFooter({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInCubit, CheckInState>(
      bloc: cubit,
      builder: (context, state) {
        int _currentStep = state.checkInSectionIndex + 1;
        int totalSteps = 17;
        debugPrint("Current step: $_currentStep");

        return CustomResponsiveBuilder(
          builder: (context, constraints, device) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: device == DeviceSize.mobile ? 0 : 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Row(
                      children: List.generate(totalSteps, (index) {
                        bool isCompleted = index < _currentStep;
                        return Container(
                          width: 20,
                          height: 5,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? context.colorScheme.secondary
                                : context.colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: cubit.backAction,
                        ),
                        StreamBuilder<bool>(
                          stream: cubit.textFieldUpdateListener.stream,
                          builder: (context, data) {
                            return CustomButton(
                              text: cubit.isOnboardingCompleted()
                                  ? "Complete CheckIn"
                                  : "Next",
                              isLoading: state.loading,
                              width: device == DeviceSize.mobile
                                  ? cubit.isOnboardingCompleted()
                                      ? 200
                                      : 90
                                  : cubit.isOnboardingCompleted()
                                      ? 300
                                      : 120,
                              height: device == DeviceSize.mobile ? 35 : 55,
                              iconData: cubit.isOnboardingCompleted()
                                  ? null
                                  : Icons.arrow_forward,
                              isDisabled: !cubit.isNextButtonEnabled(),
                              onTap: cubit.nextStepAction,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
