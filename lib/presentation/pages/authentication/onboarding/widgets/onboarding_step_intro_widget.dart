import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class OnboardingStepIntroWidget extends StatelessWidget {
  final String part;
  final String title;
  final Widget subTitle;
  const OnboardingStepIntroWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.part});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.sh * 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Part $part",
            style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onSurface),
          ),
          const SizedBox(
            height: 10,
          ),
          subTitle,
        ],
      ),
    );
  }
}
