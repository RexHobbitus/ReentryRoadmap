import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_title.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_section_container.dart';
import '../../../../../../widgets/custom_check_box.dart';
import 'about_provider_categories_sub_section.dart';
import 'about_provider_eligibility_and_feature_sub_section.dart';

class AboutProviderAllPrograms extends StatefulWidget {
  final ProviderDetailCubit cubit;

  AboutProviderAllPrograms({super.key, required this.cubit});

  @override
  State<AboutProviderAllPrograms> createState() =>
      _AboutProviderAllProgramsState();
}

class _AboutProviderAllProgramsState extends State<AboutProviderAllPrograms> {
  List<Program> programs = [];

  ProviderDetailState get state => widget.cubit.state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    programs = state.provider.onboardingInfo?.programs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderDetailTitle(title: "All Programs"),
        for (var program in programs)
          CustomSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.name??"N/A",
                  style: context.textTheme.titleMedium,
                ),
                const CustomCheckBox(
                  text: "Select to Contact",
                ),
                const SizedBox(
                  height: 20,
                ),
                AboutProviderCategoriesSubSection(
                  cubit: widget.cubit,
                ),
                AboutProviderEligibilityAndFeatureSubSection(
                  eligibility: program.eligibilityCriteria??[],
                  features: program.features??[],
                ),
              ],
            ),
          )
      ],
    );
  }
}
