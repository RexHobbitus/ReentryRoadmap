import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../../../../widgets/custom_option_tile.dart';

class ProgramServiceGeneralServiceSubCategoriesSection extends StatefulWidget {
  const ProgramServiceGeneralServiceSubCategoriesSection({super.key});

  @override
  State<ProgramServiceGeneralServiceSubCategoriesSection> createState() =>
      _ProgramServiceGeneralServiceSubCategoriesSectionState();
}

class _ProgramServiceGeneralServiceSubCategoriesSectionState
    extends State<ProgramServiceGeneralServiceSubCategoriesSection> {
  List<ServiceCategory> selectedCategories = [];

  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategories = cubit.selectedCategoriesForGeneralService;
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
                    "Under ${selectedCategories[index].title}, what sub categories applies to your general service?",
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
                      isSelected: cubit.generalServiceInfo
                          .serviceCategories![index].subCategories!
                          .contains(subCategory),
                      onTap: () {
                        setState(() {
                          if (cubit.generalServiceInfo.serviceCategories![index]
                              .subCategories!
                              .contains(subCategory)) {
                            cubit.generalServiceInfo.serviceCategories![index]
                                .subCategories!
                                .remove(subCategory);
                          } else {
                            cubit.generalServiceInfo.serviceCategories![index]
                                .subCategories!
                                .add(subCategory);
                          }
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
                    "Under ${selectedCategories[index].title}, what sub categories applies to your general service?",
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
                      isSelected: cubit.generalServiceInfo
                          .serviceCategories![index].subCategories!
                          .contains(subCategory),
                      onTap: () {
                        setState(() {
                          if (cubit.generalServiceInfo.serviceCategories![index]
                              .subCategories!
                              .contains(subCategory)) {
                            cubit.generalServiceInfo.serviceCategories![index]
                                .subCategories!
                                .remove(subCategory);
                          } else {
                            cubit.generalServiceInfo.serviceCategories![index]
                                .subCategories!
                                .add(subCategory);
                          }
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
}
