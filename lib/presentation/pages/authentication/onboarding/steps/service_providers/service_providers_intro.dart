import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

class ServiceProvidersIntro extends StatelessWidget {
  const ServiceProvidersIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Part 4",style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 10,),
        Text("Your Service Providers",style: context.textTheme.titleLarge?.copyWith(
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
                text: " keep track of your providers",
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary
                ),
              ),
              const TextSpan(
                text: " in our system",
              ),

            ]
        ))

      ],
    );
  }
}
