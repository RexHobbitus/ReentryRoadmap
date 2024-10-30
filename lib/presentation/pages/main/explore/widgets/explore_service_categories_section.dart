import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/program_category_card.dart';

class ExploreServiceCategoriesSection extends StatelessWidget {
  final ExploreCubit cubit;

  const ExploreServiceCategoriesSection({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      // Define the item width (you can adjust this value as needed)
      double itemWidth = deviceSize==DeviceSize.web
          ? 150
          : 130;

      // Calculate the number of columns based on the screen width
      int crossAxisCount = (constraints.maxWidth / itemWidth).floor();
      return AlignedGridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 13,
        crossAxisSpacing: 13,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: kServiceCategories.length + 1,
        itemBuilder: (context, index) {
          return ProgramCategoryCard(
            category: index == kServiceCategories.length
                ? kPersonalizedServiceCategory
                : kServiceCategories[index],
            onTap: cubit.categoryAction,
            isWebMode: deviceSize == DeviceSize.web,
          );
        },
      );
    });
  }
}
