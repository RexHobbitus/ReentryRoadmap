import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';

class PersonalDetailsPhoneSection extends StatelessWidget {
  const PersonalDetailsPhoneSection({super.key});

  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please provide your phone number",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          initialValue: cubit.phoneNumber,
          keyboard: TextInputType.phone,
          onChange: (val){
            cubit.phoneNumber=val;
            cubit.notifyTextFieldUpdates();
          },
        ),
      ],
    );
  }
}
