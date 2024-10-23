import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderOfficialFaxSection extends StatelessWidget {
  const ProviderOfficialFaxSection({super.key});

  ProviderOnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "Please provide your official fax number",
        ),
        Wrap(
          spacing: 15,
          children: [
            kIsWeb
                ? CustomTextField(
                    width: double.infinity,
                    initialValue: cubit.faxNumber,
                    onChange: (val) {
                      cubit.faxNumber = val;
                      cubit.notifyTextFieldUpdates();
                    },
                  )
                : CustomTextField(
                    initialValue: cubit.faxNumber,
                    onChange: (val) {
                      cubit.faxNumber = val;
                      cubit.notifyTextFieldUpdates();
                    },
                  ),
          ],
        )
      ],
    );
  }
}
