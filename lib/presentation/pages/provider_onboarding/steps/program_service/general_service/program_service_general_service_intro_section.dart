import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_subprogram_intro_widget.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../provider_onboarding_cubit.dart';

class ProgramServiceGeneralServiceIntroSection extends StatefulWidget {
  const ProgramServiceGeneralServiceIntroSection({super.key});

  @override
  State<ProgramServiceGeneralServiceIntroSection> createState() => _ProgramServiceGeneralServiceIntroSectionState();
}

class _ProgramServiceGeneralServiceIntroSectionState extends State<ProgramServiceGeneralServiceIntroSection> {
  ProviderOnboardingCubit get cubit => getIt();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderOnboardingSubprogramIntroWidget(
      title: "General Services",
      subTitle: Text("Please fill out the following screens for your ",
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.tertiary,
          )),
    );
  }

  void _checkEnableNextForThisSection() {
    cubit.isNextButtonEnabled.value = true;
  }
}
