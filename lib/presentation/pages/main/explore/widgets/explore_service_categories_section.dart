import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';

class ExploreServiceCategoriesSection extends StatelessWidget {
  final ExploreCubit cubit;

  const ExploreServiceCategoriesSection({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Define the item width (you can adjust this value as needed)
      double itemWidth = constraints.maxWidth>kMenuBreakPoint?130:100.0;

      // Calculate the number of columns based on the screen width
      int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

      return AlignedGridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 13,
        crossAxisSpacing: 13,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount:kServiceCategories.length,
        itemBuilder: (context, index) {
          return _serviceCategoryWidget(
            context: context,
            asset: kServiceCategories[index].icon,
            title: kServiceCategories[index].title,
          );
        },
      );
    });
  }

  Widget _serviceCategoryWidget(
      {required BuildContext context,
      required String asset,
      required String title}) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 115,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: context.themeData.cardColor,
          border: Border.all(color: context.themeData.colorScheme.tertiary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                asset,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.themeData.colorScheme.onTertiary,
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
