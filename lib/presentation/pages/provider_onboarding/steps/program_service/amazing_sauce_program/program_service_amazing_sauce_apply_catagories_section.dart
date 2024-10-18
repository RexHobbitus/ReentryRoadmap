// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceAmazingSauceApplyCatagoriesSection extends StatefulWidget {
  const ProgramServiceAmazingSauceApplyCatagoriesSection({super.key});

  @override
  _ProgramServiceAmazingSauceApplyCatagoriesSectionState createState() =>
      _ProgramServiceAmazingSauceApplyCatagoriesSectionState();
}

class _ProgramServiceAmazingSauceApplyCatagoriesSectionState
    extends State<ProgramServiceAmazingSauceApplyCatagoriesSection> {
  ProviderOnboardingCubit get cubit => getIt();

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
              return _serviceCategoryWidget(
                context: context,
                asset: cubit.amazingSauceCatagoriesList[index].icon,
                title: cubit.amazingSauceCatagoriesList[index].title,
                index: index,
              );
            },
          );
        }),
      ],
    );
  }

  Widget _serviceCategoryWidget({
    required BuildContext context,
    required String asset,
    required String title,
    required int index,
  }) {
    bool isSelected = cubit.isCategorySelected(title);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            cubit.removeCategory(title);
            print(cubit.amazingSauceCategories);
          } else {
            cubit.addCategory(title);
            print(cubit.amazingSauceCategories);
          }
        });
      },
      child: Container(
        height: 115,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? context
                  .themeData.colorScheme.secondary // Change color when selected
              : context.themeData.colorScheme.primary.withOpacity(0.0),
          border: Border.all(
            color: isSelected
                ? context.themeData.colorScheme.primary
                : context.themeData.colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                asset,
                height: 30,
                color: isSelected
                    ? Colors.white
                    : context.themeData.colorScheme.secondary,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? context.themeData.colorScheme.surfaceBright
                      : context.themeData.colorScheme.onTertiary,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
