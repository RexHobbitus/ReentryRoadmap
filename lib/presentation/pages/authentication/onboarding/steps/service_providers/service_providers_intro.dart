import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

import '../../widgets/onboarding_step_intro_widget.dart';

class ServiceProvidersIntro extends StatelessWidget {
  const ServiceProvidersIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingStepIntroWidget(
      part: "4",
      title: "Your Service Providers",
      subTitle: RichText(
          text: TextSpan(
              text: "This helps us",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.tertiary,
              ),
              children: [
            TextSpan(
              text: " keep track of your providers",
              style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary),
            ),
            const TextSpan(
              text: " in our system",
            ),
          ])),
    );
  }
}
