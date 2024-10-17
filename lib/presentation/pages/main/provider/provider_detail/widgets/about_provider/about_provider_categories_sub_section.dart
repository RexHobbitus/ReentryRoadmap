import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../widgets/custom_expansion_tile.dart';

class AboutProviderCategoriesSubSection extends StatelessWidget {
  AboutProviderCategoriesSubSection({super.key});

  final List<String> _categories = ["Education", "Employment", "Housing"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Categories",
            style: AppStyle.providerDetailUnderlinedSubTitle(context)),
        const SizedBox(
          height: 15,
        ),
        for (var index = 0; index < _categories.length; index++)
          CustomExpansionTile(
            title: _categories[index],
            children: [
              _subCategoryTile(context: context,title: "Sub Category 1"),
              _subCategoryTile(context: context,title: "Sub Category 2"),
              _subCategoryTile(context: context,title: "Sub Category 3"),
              _subCategoryTile(context: context,title: "Sub Category 4",hideDivider: true),


            ],
          ),
      ],
    );
  }

  Widget _subCategoryTile({required BuildContext context, required String title,bool hideDivider=false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          hideDivider?const SizedBox.shrink(): const SizedBox(height: 5,),
          hideDivider?const SizedBox.shrink(): const Divider(
            thickness: 0.5,
            height: 2,
          ),
        ],
      ),
    );
  }
}
