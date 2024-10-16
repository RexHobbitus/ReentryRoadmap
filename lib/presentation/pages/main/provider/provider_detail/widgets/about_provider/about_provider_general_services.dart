import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_title.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_section_container.dart';

import 'about_provider_categories_sub_section.dart';
import 'about_provider_eligibility_and_feature_sub_section.dart';
import 'about_provider_eligibility_criteria_sub_section.dart';
import 'about_provider_feature_sub_section.dart';

class AboutProviderGeneralServices extends StatelessWidget {
  const AboutProviderGeneralServices({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProviderDetailTitle(title: "General Services"),
          CustomSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomCheckBox(
                  text: "Select to Contact",
                ),
                const SizedBox(
                  height: 20,
                ),
                AboutProviderCategoriesSubSection(),
                const AboutProviderEligibilityAndFeatureSubSection(),
              ],
            ),
          )
        ],
      );
    });
  }

}
