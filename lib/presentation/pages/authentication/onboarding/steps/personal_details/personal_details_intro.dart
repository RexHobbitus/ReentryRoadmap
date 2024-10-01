import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

class PersonalDetailsIntro extends StatelessWidget {
  const PersonalDetailsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Part 1",style: context.textTheme.titleMedium?.copyWith(
          color: context.colorScheme.tertiary,
          fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 10,),
        Text("Personal Details",style: context.textTheme.titleLarge?.copyWith(
         fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 10,),
        RichText(text: TextSpan(
          text: "This helps us",
          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600,
              color: context.colorScheme.tertiary,
          ),
          children: [
            TextSpan(
              text: " build your profile",
              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600,
              color: context.colorScheme.primary
              ),
            ),
            const TextSpan(
              text: " and",
            ),
            TextSpan(
              text: " find services you are eligible for",
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
