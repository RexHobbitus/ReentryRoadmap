import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';
import '../../../../../widgets/custom_date_picker_field.dart';
import '../../onboarding_cubit.dart';

class PersonalDetailsDobSection extends StatelessWidget {
  const PersonalDetailsDobSection({super.key});
  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your Date of Birth?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomDatePickerField(
          controller: cubit.txtDob,
        ),
      ],
    );
  }
}
