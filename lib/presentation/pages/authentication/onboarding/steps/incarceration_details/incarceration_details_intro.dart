import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

import '../../widgets/onboarding_step_intro_widget.dart';

class IncarcerationDetailsIntro extends StatelessWidget {
  const IncarcerationDetailsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingStepIntroWidget(
      part: "2",
      title: "Incarceration Details",
      subTitle: RichText(
          text: TextSpan(
              text: "This helps us",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.tertiary,
              ),
              children: [
            TextSpan(
              text: " understand your needs",
              style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary),
            ),
            const TextSpan(
              text: " and",
            ),
            TextSpan(
              text: " find services you are eligible for",
              style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary),
            ),
          ])),
    );
  }
}
