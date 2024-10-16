import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class CustomSectionContainer extends StatelessWidget {
  final Widget child;

  const CustomSectionContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sw,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.themeData.cardColor,
          border: Border.all(color: context.colorScheme.tertiaryContainer, width: 2)),
      child: child,
    );
  }
}
