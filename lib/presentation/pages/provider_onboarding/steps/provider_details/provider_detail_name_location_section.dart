import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';


class ProviderDetailNameLocationSection extends StatelessWidget {
  const ProviderDetailNameLocationSection({super.key});

  ProviderOnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "What is the name of your provider location?",
          subTitle: 'This is the location the services are offered at. It could be the main office of the organization or it could have a different name',
        ),
        Wrap(
          spacing: 15,
          children: [
            CustomTextField(
              initialValue: cubit.nameProviderLocation,
              onChange: (val){
                cubit.nameProviderLocation=val;
                cubit.notifyTextFieldUpdates();
              },
            ),
            
          ],
        )
      ],
    );
  }
}
