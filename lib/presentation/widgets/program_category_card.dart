import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';

import '../../core/utils/constants.dart';

class ProgramCategoryCard extends StatelessWidget {
  final ServiceCategory category;
  final Function(ServiceCategory) onTap;
  final bool isSelected;
  final bool isWebMode;

  const ProgramCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
    this.isWebMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            onTap.call(category);
          },
          child: Container(
            height: isWebMode ? 150 : 115,
            width: isWebMode ? 150 : 115,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin:  EdgeInsets.only(top: category==kPersonalizedServiceCategory? 10:10),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.themeData.colorScheme
                      .secondary // Change color when selected
                  : context.themeData.cardColor,
              border: Border.all(
                  color: isSelected
                      ? context.themeData.colorScheme.primary
                      : context.themeData.colorScheme.tertiaryContainer,
                  width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: Center(
                    child: SvgPicture.asset(
                      category.icon,
                      height: 30,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      category.title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? context.themeData.colorScheme.surfaceBright
                            : context.themeData.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Visibility(
              visible: category==kPersonalizedServiceCategory,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                margin: const EdgeInsets.symmetric(horizontal:10),
                decoration: BoxDecoration(color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Learn more !",
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
