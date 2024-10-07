import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

class CustomOptionTile extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String subTitle;

  final VoidCallback? onTap;

  const CustomOptionTile({
    super.key,
    this.isSelected = false,
    required this.title,
    this.subTitle="",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context,constraints) {
          return Container(
            width:constraints.maxWidth>=kMenuBreakPoint?200:constraints.maxWidth,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.secondary
                  : context.colorScheme.tertiary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? context.colorScheme.onSecondary
                        : context.colorScheme.onTertiaryContainer,
                  ),
                ),
                subTitle.isEmpty?const SizedBox.shrink():
                Text(
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
        }
      ),
    );
  }
}
