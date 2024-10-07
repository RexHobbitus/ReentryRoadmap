import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_date_picker_field.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';
class IncarcerationDetailsFirstIncarceratedDate extends StatelessWidget {
  const IncarcerationDetailsFirstIncarceratedDate({super.key});

  OnboardingCubit get cubit  => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "When were you first incarcerated?",
        ),
        CustomDatePickerField(
          controller:cubit.txtFirstIncarceratedDate,
        ),
      ],
    );
  }
}
