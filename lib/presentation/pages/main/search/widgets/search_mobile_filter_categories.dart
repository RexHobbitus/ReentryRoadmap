import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_category_mobile.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_fields.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class SearchMobileFilterCategories extends StatelessWidget {
  const SearchMobileFilterCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Filters",
                    style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Reset",
                    style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSurface.withOpacity(0.5)),
                  ),
                ],
              ),
              const CloseButton(
                style: ButtonStyle(visualDensity: VisualDensity(horizontal: -4, vertical: -4)),
              )
            ],
          ),
        ),
        const Divider(
          color: Color(0xFFEEEEEE),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                SearchFilterCategoryMobile(
                  title: "Category",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ),
                const SizedBox(height: 30),
                SearchFilterCategoryMobile(
                  title: "Subcategory",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ),
                const SizedBox(height: 30),
                const SearchFilterFields(),
                const SizedBox(height: 30),
                SearchFilterCategoryMobile(
                  title: "Features",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ),
                const SizedBox(height: 30),
                SearchFilterCategoryMobile(
                  title: "Eligibility",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: "Apply Filters",
                  width: double.infinity,
                  onTap: () {},
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
