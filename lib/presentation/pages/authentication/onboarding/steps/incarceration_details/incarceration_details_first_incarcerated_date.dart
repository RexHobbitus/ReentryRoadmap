import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_date_picker_field.dart';
import '../../onboarding_cubit.dart';
class IncarcerationDetailsFirstIncarceratedDate extends StatelessWidget {
  const IncarcerationDetailsFirstIncarceratedDate({super.key});

  OnboardingCubit get cubit  => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "When were you first incarcerated?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomDatePickerField(
          controller:cubit.txtFirstIncarceratedDate,
        ),
      ],
    );
  }
}
