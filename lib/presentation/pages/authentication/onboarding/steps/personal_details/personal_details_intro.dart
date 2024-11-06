import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../widgets/onboarding_step_intro_widget.dart';

class PersonalDetailsIntro extends StatelessWidget {
  const PersonalDetailsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingStepIntroWidget(
      part: "1",
      title: "Personal Details",
      subTitle: RichText(
          text: TextSpan(
              text: "This helps us",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.tertiary,
              ),
              children: [
            TextSpan(
              text: " build your profile",
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: context.colorScheme.primary),
            ),
            const TextSpan(
              text: " and",
            ),
            TextSpan(
              text: " find services you are eligible for",
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: context.colorScheme.primary),
            ),
          ])),
    );
  }
}
