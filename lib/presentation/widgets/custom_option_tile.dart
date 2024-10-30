import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class CustomOptionTile extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String subTitle;

  final VoidCallback? onTap;

  const CustomOptionTile({
    super.key,
    this.isSelected = false,
    required this.title,
    this.subTitle = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomResponsiveBuilder(builder: (context, constraints, device) {
        return Container(
          width: device == DeviceSize.web ? 400 : constraints.maxWidth,
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: device == DeviceSize.web ? 25 : 15),
          margin: EdgeInsets.symmetric(
              vertical: 5, horizontal: device == DeviceSize.web ? 5 : 0),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.secondary
                : context.colorScheme.surfaceDim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? context.colorScheme.onSecondary
                      : context.colorScheme.onTertiaryContainer,
                ),
              ),
              subTitle.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                      subTitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? context.colorScheme.onPrimary
                            : context.colorScheme.tertiary,
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
