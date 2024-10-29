// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/program_category.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/program_category_card.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceProgramOfferApplyCatagoriesSection extends StatefulWidget {
  final int index;

  const ProgramServiceProgramOfferApplyCatagoriesSection(
      {super.key, required this.index});

  @override
  _ProgramServiceProgramOfferApplyCatagoriesSectionState createState() =>
      _ProgramServiceProgramOfferApplyCatagoriesSectionState();
}

class _ProgramServiceProgramOfferApplyCatagoriesSectionState
    extends State<ProgramServiceProgramOfferApplyCatagoriesSection> {
  ProviderOnboardingCubit get cubit => getIt();

  List<ServiceCategory> _selectedCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCategories = cubit.selectedCategories[widget.index];
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
          title: "What categories apply to the program?",
          subTitle: "Select all that apply",
        ),
        LayoutBuilder(builder: (context, constraints) {
          double itemWidth =
              constraints.maxWidth > kMenuBreakPoint ? 130 : 100.0;
          int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

          return AlignedGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 13,
            crossAxisSpacing: 13,
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: kServiceCategories.length,
            itemBuilder: (context, index) {
              return ProgramCategoryCard(
                category: kServiceCategories[index],
                onTap: _onTapCategory,
                isSelected:
                    _selectedCategories.contains(kServiceCategories[index]),
              );
            },
          );
        }),
      ],
    );
  }

  _onTapCategory(ServiceCategory serviceCategory) {
    setState(() {
      if (_selectedCategories.contains(serviceCategory)) {
        _selectedCategories.remove(serviceCategory);
      } else {
        _selectedCategories.add(serviceCategory);
      }
    });
    cubit.selectedPrograms[widget.index].programCategories = _selectedCategories
        .map((category) => ProgramCategory(
              title: category.title,
              subCategories: [],
            ))
        .toList();
    _checkEnableNextForThisSection();
  }

  void _checkEnableNextForThisSection() {
    if (_selectedCategories.isNotEmpty) {
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }
}
