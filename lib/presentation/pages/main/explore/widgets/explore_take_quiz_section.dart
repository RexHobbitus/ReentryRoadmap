import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class ExploreTakeQuizSection extends StatelessWidget {
  const ExploreTakeQuizSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.themeData.colorScheme.secondary),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Take our quiz to get personalized results!",
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Share your reentry journey with us to help us better understand your needs.",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          LayoutBuilder(
            builder: (context,constraints) {
              debugPrint(constraints.maxWidth.toString());
              return CustomButton(
                text: "Learn More",
                width: constraints.maxWidth>350?200:constraints.maxWidth,
                onTap: () {},
              );
            }
          )
        ],
      ),
    );
  }
}
