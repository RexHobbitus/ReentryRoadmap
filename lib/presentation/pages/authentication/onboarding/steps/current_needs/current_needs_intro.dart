import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
class CurrentNeedsIntro extends StatelessWidget {
  const CurrentNeedsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Part 3",style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 10,),
        Text("Your current needs",style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 10,),
        RichText(text: TextSpan(
            text: "This helps us deep dive into your needs to",
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600,
              color: context.colorScheme.tertiary,
            ),
            children: [
              TextSpan(
                text: " find you the best services",
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary
                ),
              ),
            ]
        ))

      ],
    );
  }
}
