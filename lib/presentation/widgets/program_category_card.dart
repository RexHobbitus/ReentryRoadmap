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
                category.icon,
                height: 30,
                color: isSelected
                    ? Colors.white
                    : context.themeData.colorScheme.secondary,
              ),
              const SizedBox(height: 10),
              Text(
                category.title,
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
