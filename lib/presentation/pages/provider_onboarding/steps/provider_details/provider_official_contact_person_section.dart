import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderOfficialContactPersonSection extends StatefulWidget {
  const ProviderOfficialContactPersonSection({super.key});

  @override
  State<ProviderOfficialContactPersonSection> createState() => _ProviderOfficialContactPersonSectionState();
}

class _ProviderOfficialContactPersonSectionState extends State<ProviderOfficialContactPersonSection> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "Please provide the name of your contact person",
        ),
        Wrap(
          spacing: 15,
          children: [
            CustomTextField(
              initialValue: cubit.contactPerson,
              onChange: (val) {
                cubit.contactPerson = val;
                _checkEnableNextForThisSection();
              },
            ),
          ],
        )
      ],
    );
  }

  void _checkEnableNextForThisSection() {
    cubit.isNextButtonEnabled.value = true;
  }
}
