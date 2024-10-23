import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_step_intro_widget.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_subprogram_intro_widget.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../provider_onboarding_cubit.dart';

class ProgramServiceAboutProgramOfferSection extends StatelessWidget {
  final int index;
  const ProgramServiceAboutProgramOfferSection({super.key,required this.index});

  ProviderOnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return ProviderOnboardingSubprogramIntroWidget(
      title: '${cubit.selectedPrograms[index].name} Program',
      subTitle:
          Text("Tell us more about your specific programs and general services",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.tertiary,
              )),
    );
  }
}
