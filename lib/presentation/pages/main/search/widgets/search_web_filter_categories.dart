import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_category_popup.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_category_web.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_fields.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_sub_category_popup.dart';

class SearchWebFilterCategories extends StatelessWidget {
  final SearchCubit cubit;

  const SearchWebFilterCategories({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Filter",
              style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Reset"),
              // style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(height: 10),
        SearchFilterCategoryWeb(
          title: "Category",
          list: kServiceCategories.map((e) => e.title).toList(),
          selectedList: kServiceCategories.map((e) => e.title).toList(),
          onMore: () {
            cubit.navigator.navigator.showDialogBox(
                context,
                SearchFilterCategoryPopup(
                  title: "Category",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ));
          },
        ),
        const SizedBox(height: 30),
        SearchFilterCategoryWeb(
          title: "Subcategory",
          list: kServiceCategories.map((e) => e.title).toList(),
          selectedList: kServiceCategories.map((e) => e.title).toList(),
          onMore: () {
            cubit.navigator.navigator.showDialogBox(context, SearchFilterSubCategoryPopup());
          },
        ),
        const SizedBox(height: 30),
        const SearchFilterFields(),
        const SizedBox(height: 30),
        SearchFilterCategoryWeb(
          title: "Features",
          list: kServiceCategories.map((e) => e.title).toList(),
          selectedList: kServiceCategories.map((e) => e.title).toList(),
          onMore: () {
            cubit.navigator.navigator.showDialogBox(
                context,
                SearchFilterCategoryPopup(
                  title: "Features",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ));
          },
        ),
        const SizedBox(height: 30),
        SearchFilterCategoryWeb(
          title: "Eligibility",
          list: kServiceCategories.map((e) => e.title).toList(),
          selectedList: kServiceCategories.map((e) => e.title).toList(),
          onMore: () {
            cubit.navigator.navigator.showDialogBox(
                context,
                SearchFilterCategoryPopup(
                  title: "Eligibility",
                  list: kServiceCategories.map((e) => e.title).toList(),
                  selectedList: kServiceCategories.map((e) => e.title).toList(),
                ));
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
