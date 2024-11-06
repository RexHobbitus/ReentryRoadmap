import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
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
        const OnboardingTitleWidget(
          title: "What is your Date of Birth?",
        ),
        Row(
          children: [
            Expanded(
              child: CustomDatePickerField(
                initialValue: cubit.selectedDob,
                onChange: (date) {
                  cubit.selectedDob = date;
                  cubit.notifyTextFieldUpdates();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
