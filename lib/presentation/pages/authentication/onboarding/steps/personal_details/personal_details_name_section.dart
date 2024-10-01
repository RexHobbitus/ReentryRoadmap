import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class PersonalDetailsNameSection extends StatelessWidget {
  const PersonalDetailsNameSection({super.key});

  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your full name?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(controller: cubit.txtFullName, hint: ""),
      ],
    );
  }
}
