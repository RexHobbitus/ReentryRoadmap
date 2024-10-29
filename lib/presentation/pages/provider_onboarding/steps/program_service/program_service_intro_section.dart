import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_step_intro_widget.dart';

import '../../../../../service_locator/service_locator.dart';
import '../../provider_onboarding_cubit.dart';

class ProgramServiceIntroSection extends StatefulWidget {
  const ProgramServiceIntroSection({super.key});

  @override
  State<ProgramServiceIntroSection> createState() => _ProgramServiceIntroSectionState();
}

class _ProgramServiceIntroSectionState extends State<ProgramServiceIntroSection> {
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
    return ProviderOnboardingStepIntroWidget(
      part: "2",
      title: "Program & Service Details",
      subTitle:
          Text("Tell us more about your specific programs and general services",
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
