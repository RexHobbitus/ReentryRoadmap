import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_step_intro_widget.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_subprogram_intro_widget.dart';

class ProgramServiceGeneralServiceIntroSection extends StatelessWidget {
  const ProgramServiceGeneralServiceIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderOnboardingSubprogramIntroWidget(
      title: "General Services",
      subTitle: Text("Please fill out the following screens for your ",
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.tertiary,
          )),
    );
  }
}