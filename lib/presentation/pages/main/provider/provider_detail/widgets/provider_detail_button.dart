import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class ProviderDetailButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isPrimary;

  const ProviderDetailButton({
    super.key,
    required this.title,
    required this.icon,
    this.isPrimary=false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        decoration: BoxDecoration(
            color:isPrimary?context.colorScheme.primary:context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: context.colorScheme.onSecondary,
              size: 15,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              title,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
