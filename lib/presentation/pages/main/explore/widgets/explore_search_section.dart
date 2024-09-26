import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../widgets/custom_textfield.dart';

class ExploreSearchSection extends StatelessWidget {
  const ExploreSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello There!",
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "What are you looking for today?",
                style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.themeData.colorScheme.tertiary),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          LayoutBuilder(
            builder: (context,constraints) {
              debugPrint(constraints.maxWidth.toString());
              return CustomTextField(
                controller: TextEditingController(),
                hint: "Search",
                suffixPath: Assets.search,
                bottomPadding: 0,
                width: constraints.maxWidth>500?500:constraints.maxWidth,
              );
            }
          ),
        ],
      ),
    );
  }
}
