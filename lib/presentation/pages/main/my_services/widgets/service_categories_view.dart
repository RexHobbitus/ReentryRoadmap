import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/presentation/widgets/service_card_category_chip.dart';

class ServiceCategoriesView extends StatelessWidget {
  const ServiceCategoriesView({super.key});

  final List<String> categories = const [
    "Education",
    "Employment",
    "Housing",
    "Education",
    "Employment",
    "Housing"
  ];

  final int maxLimit = 5;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //  mainAxisSize: MainAxisSize.min,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var category in List.from(categories).take(maxLimit).toList())
          ServiceCardCategoryChip(
            title: category,
          ),
        categories.length > maxLimit
            ? Text(
                "+ ${categories.length - maxLimit} More",
                style: context.textTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.tertiary,
                    fontSize: Responsive.getResponsiveValueDouble(context, 10, 12, 12)),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
