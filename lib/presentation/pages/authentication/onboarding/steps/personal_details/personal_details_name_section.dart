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
              initialValue: cubit.firstName,
              onChange: (val){
                cubit.firstName=val;
                cubit.notifyTextFieldUpdates();
              },
              label: "First Name",
            ),
            CustomTextField(
              initialValue: cubit.middleName,
              label: "Middle Name (optional)",
              onChange: (val){
                cubit.middleName=val;
                cubit.notifyTextFieldUpdates();
              },
            ),
            CustomTextField(
              initialValue: cubit.lastName,
              label: "Last Name",
              onChange: (val){
                cubit.lastName=val;
                cubit.notifyTextFieldUpdates();
                debugPrint("value");
              },
            ),
          ],
        )
      ],
    );
  }
}
