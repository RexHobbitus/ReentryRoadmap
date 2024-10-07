import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';
import '../../../../../widgets/custom_date_picker_field.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class IncarcerationDetailsLatestReleaseDate extends StatelessWidget {
  const IncarcerationDetailsLatestReleaseDate({super.key});
  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What was your latest release date?",
        ),
        CustomDatePickerField(
          controller: cubit.txtLatestReleaseDate,
        ),
      ],
    );
  }
}
