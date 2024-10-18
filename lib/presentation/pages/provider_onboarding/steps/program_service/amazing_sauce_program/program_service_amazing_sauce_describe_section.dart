import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceAmazingSauceDescribeSection extends StatelessWidget {
  final int index;
  const ProgramServiceAmazingSauceDescribeSection({super.key,required this.index,});

  ProviderOnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "Describe the program in a few sentences",
        ),
        Wrap(
          spacing: 15,
          children: [
            CustomTextField(
              isDetail: true,
              initialValue: cubit.amazingSauceDetail[index],
              onChange: (val) {
                cubit.amazingSauceDetail[index] = val;
                cubit.notifyTextFieldUpdates();
              },
            ),
          ],
        )
      ],
    );
  }
}
