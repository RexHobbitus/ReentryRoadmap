import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../widgets/service_card.dart';

class ExplorePopularServicesSection extends StatelessWidget {
  const ExplorePopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Popular Services",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              "Get Personalized Recommendations >",
              style: context.textTheme.titleMedium?.copyWith(
                color: context.themeData.colorScheme.tertiary,
                decoration: TextDecoration.underline,
                height: 2
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        const ServiceCard(

        ),

      ],
    );
  }
}
