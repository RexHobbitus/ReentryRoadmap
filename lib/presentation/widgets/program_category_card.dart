import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';

class ProgramCategoryCard extends StatelessWidget {
  final ServiceCategory category;
  final Function(ServiceCategory) onTap;
  final bool isSelected;

  const ProgramCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(category);
      },
      child: Container(
        height: 115,
        width: 115,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? context
                  .themeData.colorScheme.secondary // Change color when selected
              : context.themeData.cardColor,
          border: Border.all(
            color: isSelected
                ? context.themeData.colorScheme.primary
                : context.themeData.colorScheme.tertiaryContainer,
            width: 2
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                category.icon,
                height: 30,
                color: isSelected
                    ? Colors.white
                    : null,
              ),
              const SizedBox(height: 11),
              Text(
                category.title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? context.themeData.colorScheme.surfaceBright
                      : context.themeData.colorScheme.onSurface,
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
