import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

class CustomTitleCard extends StatelessWidget {
  final String title;
  final Widget child;
  const CustomTitleCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sw,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: context.themeData.cardColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _heading(context: context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _heading({required BuildContext context}) {
    return Container(
      width: context.sw,
      padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding, vertical: 10),
      decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Text(
        title,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }
}
