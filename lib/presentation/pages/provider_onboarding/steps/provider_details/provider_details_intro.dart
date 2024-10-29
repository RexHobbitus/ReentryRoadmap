import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_step_intro_widget.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../provider_onboarding_cubit.dart';

class ProviderDetailsIntro extends StatefulWidget {
  const ProviderDetailsIntro({super.key});

  @override
  State<ProviderDetailsIntro> createState() => _ProviderDetailsIntroState();
}

class _ProviderDetailsIntroState extends State<ProviderDetailsIntro> {
  ProviderOnboardingCubit get cubit =>getIt();

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
      part: "1",
      title: "Provider Details",
      subTitle: Text("Tell us more about your organization",
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
