import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../widgets/custom_responsive_builder.dart';

class OnboardingFooter extends StatelessWidget {
  final OnboardingCubit cubit;
  const OnboardingFooter({super.key,required this.cubit,});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context,constraints,device) {
        return Padding(
          padding:  EdgeInsets.only(bottom: device==DeviceSize.mobile?0:20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StepProgressIndicator(
                totalSteps: 4,
                currentStep: 1,
                selectedColor: context.colorScheme.secondary,
                unselectedColor: context.colorScheme.tertiaryContainer,
                padding: 4,
                size: 5,
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      iconAlignment: IconAlignment.start,
                      icon:  Icon(Icons.arrow_back,size: 15,color: context.colorScheme.onSurface,),
                      label:  Text("Back",style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline
                      ),),
                      onPressed: cubit.backAction,
                    ),
                    CustomButton(
                      text: "Next",
                      width: device==DeviceSize.mobile?90:120,
                      height: device==DeviceSize.mobile?35:55,
                      iconData: Icons.arrow_forward,
                      onTap: cubit.nextStepAction,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
