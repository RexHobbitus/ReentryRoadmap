import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import '../../../../../../../core/utils/assets.dart';
import 'about_provider_eligibility_criteria_sub_section.dart';
import 'about_provider_feature_sub_section.dart';

class AboutProviderEligibilityAndFeatureSubSection extends StatelessWidget {
  final List<String> eligibility;
  final List<String> features;
  final bool isLoggedIn;

  const AboutProviderEligibilityAndFeatureSubSection({
    super.key,
    required this.features,
    required this.eligibility,
    this.isLoggedIn=false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context, constraints, deviceSize) {
        return Padding(
          padding:  EdgeInsets.symmetric(vertical: isLoggedIn?5:15),
          child: deviceSize == DeviceSize.web
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _eligibilitySection(isWeb: true,context: context),
                    _featureSection(isWeb: true,context: context),
                  ],
                )
              : Column(
                  children: [
                    _eligibilitySection(context: context),
                    const SizedBox(height: 20,),
                    _featureSection(context: context),
                  ],
                ),
        );
      },
    );
  }

  _eligibilitySection({bool isWeb = false,required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoggedIn?Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CustomButton(
            text: "Eligible!",
            iconPath: Assets.starCheck,
            onTap: () {},
            isSecondary: true,
            style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSecondary
            ),
            width: isWeb ? 120 : null,
          ),
        ):const SizedBox.shrink(),
        AboutProviderEligibilityCriteriaSubSection(
          eligibilities: eligibility,
        ),
      ],
    );
  }

  _featureSection({bool isWeb = false,required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoggedIn?Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CustomButton(
            text: "Recommended for you",
            iconPath: Assets.starCheck,
            onTap: () {},
            isSecondary: true,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSecondary
            ),
            width: isWeb ? 200 : null,
          ),
        ):const SizedBox.shrink(),
        AboutProviderFeatureSubSection(
          features: features,
        ),
      ],
    );
  }
}
