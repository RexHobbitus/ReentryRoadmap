import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_title.dart';

import 'package:reentry_roadmap/presentation/widgets/custom_section_container.dart';

import '../../../../../../../core/utils/assets.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_check_box.dart';
import 'about_provider_categories_sub_section.dart';
import 'about_provider_eligibility_and_feature_sub_section.dart';
import 'about_provider_eligibility_criteria_sub_section.dart';
import 'about_provider_feature_sub_section.dart';

class AboutProviderAllPrograms extends StatelessWidget {
   AboutProviderAllPrograms({super.key});

  final List<String> programs=["Supernova Program","Management Program"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderDetailTitle(title: "All Programs"),
        for(var program in programs)
        CustomSectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(program,style: context.textTheme.titleMedium,),
              const CustomCheckBox(
                text: "Select to Contact",
              ),
              const SizedBox(
                height: 20,
              ),
              AboutProviderCategoriesSubSection(),
              AboutProviderEligibilityAndFeatureSubSection(),
            ],
          ),
        )
      ],
    );
  }
}
