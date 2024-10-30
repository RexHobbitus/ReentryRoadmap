import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../widgets/onboarding_step_intro_widget.dart';

class CurrentNeedsIntro extends StatelessWidget {
  const CurrentNeedsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingStepIntroWidget(
      part: "3",
      title: "Your current needs",
      subTitle: RichText(
          text: TextSpan(
              text: "This helps us deep dive into your needs to",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.tertiary,
              ),
              children: [
            TextSpan(
              text: " find you the best services",
              style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary),
            ),
          ])),
    );
  }
}
