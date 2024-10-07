import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../widgets/onboarding_title_widget.dart';

class PersonalDetailsNameSection extends StatelessWidget {
  const PersonalDetailsNameSection({super.key});

  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What is your full name?",
        ),
        Wrap(
          spacing: 15,
          children: [
            CustomTextField(
              controller: cubit.txtFullName,
              label: "First Name",
            ),
            CustomTextField(
              controller: cubit.txtFullName,
              label: "Middle Name (optional)",
            ),
            CustomTextField(
              controller: cubit.txtFullName,
              label: "Last Name",
            ),
          ],
        )
      ],
    );
  }
}
