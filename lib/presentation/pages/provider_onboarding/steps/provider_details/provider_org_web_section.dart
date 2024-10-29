import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderOrgWebSection extends StatefulWidget {
  const ProviderOrgWebSection({super.key});

  @override
  State<ProviderOrgWebSection> createState() => _ProviderOrgWebSectionState();
}

class _ProviderOrgWebSectionState extends State<ProviderOrgWebSection> {
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
          title: "Please enter your organization’s website",
        ),
        Wrap(
          spacing: 15,
          children: [
            kIsWeb
                ? CustomTextField(
                    width: double.infinity,
                    initialValue: cubit.orgWebsite,
                    onChange: (val) {
                      cubit.orgWebsite = val;
                      _checkEnableNextForThisSection();
                    },
                  )
                : CustomTextField(
                    initialValue: cubit.orgWebsite,
                    onChange: (val) {
                      cubit.orgWebsite = val;
                      _checkEnableNextForThisSection();
                    },
                  ),
          ],
        )
      ],
    );
  }

  void _checkEnableNextForThisSection() {
    if (cubit.orgWebsite.isNotEmpty) {
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }
}
