import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';

class ProgramServiceProgramOfferSubcatagorySection extends StatefulWidget {
  final int index;

  const ProgramServiceProgramOfferSubcatagorySection(
      {super.key, required this.index});

  @override
  State<ProgramServiceProgramOfferSubcatagorySection> createState() =>
      _ProgramServiceProgramOfferSubcatagorySectionState();
}

class _ProgramServiceProgramOfferSubcatagorySectionState
    extends State<ProgramServiceProgramOfferSubcatagorySection> {
  List<ServiceCategory> selectedCategories = [];

  ProviderOnboardingCubit get cubit => getIt();
  List<Program> selectedPrograms = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategories = cubit.selectedCategories[widget.index];
    selectedPrograms = cubit.selectedPrograms;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Wrap(
          direction: Axis.vertical,
          children: [
            for (int index = 0; index < selectedCategories.length; index++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Under ${selectedCategories[index].title}, what sub categories applies to program",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (var subCategory
                      in selectedCategories[index].subCategories)
                    CustomOptionTile(
                      title: subCategory,
                      isSelected: selectedPrograms[widget.index]
                          .programCategories![index]
                          .subCategories!
                          .contains(subCategory),
                      onTap: () {
                        setState(() {
                          selectedPrograms[widget.index]
                                  .programCategories![index]
                                  .subCategories!
                                  .contains(subCategory)
                              ? selectedPrograms[widget.index]
                                  .programCategories![index]
                                  .subCategories!
                                  .remove(subCategory)
                              : selectedPrograms[widget.index]
                                  .programCategories![index]
                                  .subCategories!
                                  .add(subCategory);
                        });
                      },
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
          ],
        );
      } else {
        return Wrap(
          children: [
            for (int index = 0; index < selectedCategories.length; index++)
              Column(
                children: [
                  Text(
                    "Under ${selectedCategories[index].title}, what sub categories applies to program",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (var subCategory
                      in selectedCategories[index].subCategories)
                    CustomOptionTile(
                      title: subCategory,
                      isSelected: selectedPrograms[widget.index]
                          .programCategories![index]
                          .subCategories!
                          .contains(subCategory),
                      onTap: () {
                        setState(() {
                          selectedPrograms[widget.index]
                                  .programCategories![index]
                                  .subCategories!
                                  .contains(subCategory)
                              ? selectedPrograms[widget.index]
                                  .programCategories![index]
                                  .subCategories!
                                  .remove(subCategory)
                              : selectedPrograms[widget.index]
                                  .programCategories![index]
                                  .subCategories!
                                  .add(subCategory);
                        });
                      },
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
          ],
        );
      }
    });
  }

  void _checkEnableNextForThisSection() {
    cubit.isNextButtonEnabled.value = true;
  }
}
