import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_category_mobile.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_fields.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class SearchMobileFilterCategories extends StatefulWidget {
  final SearchCubit cubit;

  const SearchMobileFilterCategories({
    super.key,
    required this.cubit,
  });

  @override
  State<SearchMobileFilterCategories> createState() => _SearchMobileFilterCategoriesState();
}

class _SearchMobileFilterCategoriesState extends State<SearchMobileFilterCategories> {
  ValueNotifier<List<CategoryData>> categoryList = ValueNotifier([]);
  ValueNotifier<List<String>> features = ValueNotifier([]);
  ValueNotifier<Set<String>> selectedFeatures = ValueNotifier({});
  ValueNotifier<List<String>> eligibilities = ValueNotifier([]);
  ValueNotifier<Set<String>> selectedEligibilities = ValueNotifier({});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        bloc: widget.cubit,
        builder: (context, state) {
          categoryList.value = state.categoriesList;
          features.value = state.features;
          eligibilities.value = state.eligibilities;
          selectedEligibilities.value = state.selectedEligibilities;
          selectedFeatures.value = state.selectedFeatures;
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
                      ValueListenableBuilder(
                          valueListenable: categoryList,
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                SearchFilterCategoryMobile(
                                  onSelect: (value) {
                                    final index = categoryList.value.indexWhere((element) => element.title == value);
                                    if (index.isNegative) return;
                                    CategoryData categoryData = categoryList.value[index];
                                    if (categoryData.isSelected ?? false) {
                                      categoryData = categoryData.copyWith(
                                          subCategories: categoryData.subCategories?.map((e) => SubCategoryData(title: e.title)).toList());
                                    }
                                    categoryList.value = [...categoryList.value]
                                      ..removeAt(index)
                                      ..insert(index, categoryData.copyWith(isSelected: !(categoryData.isSelected ?? false)));
                                  },
                                  title: "Category",
                                  list: categoryList.value.map((e) => e.title ?? "").toList(),
                                  selectedList: categoryList.value.where((element) => element.isSelected ?? false).map((e) => e.title ?? "").toList(),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: categoryList,
                                  builder: (context, value, child) {
                                    List<SubCategoryData> subcategoryData = [];
                                    final selectedCategoryList = categoryList.value.where((element) => element.isSelected ?? false).toList();
                                    for (var element in selectedCategoryList) {
                                      subcategoryData.addAll(element.subCategories ?? []);
                                    }
                                    if (subcategoryData.isEmpty) return const SizedBox.shrink();
                                    return Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        SearchFilterCategoryMobile(
                                          onSelect: (value) {
                                            for (int i = 0; i < categoryList.value.length; i++) {
                                              final index =
                                                  categoryList.value[i].subCategories?.indexWhere((element) => element.title == value) ?? -1;
                                              if (!index.isNegative) {
                                                CategoryData categoryData = categoryList.value[i];
                                                categoryData = categoryData.copyWith(
                                                    subCategories: [...categoryData.subCategories ?? []]
                                                      ..removeAt(index)
                                                      ..insert(
                                                          index,
                                                          categoryData.subCategories![index]
                                                              .copyWith(isSelected: !(categoryData.subCategories![index].isSelected))));
                                                print(
                                                    "categoryData.subCategories![index]copyWith(isSelected: !(categoryData.subCategories![index].isSelected))==>${categoryData.subCategories![index].copyWith(isSelected: !(categoryData.subCategories![index].isSelected)).isSelected}");
                                                categoryList.value = [...categoryList.value]
                                                  ..removeAt(i)
                                                  ..insert(i, categoryData);
                                              }
                                            }
                                          },
                                          title: "Subcategory",
                                          list: subcategoryData.map((e) => e.title).toList().toSet().toList(),
                                          selectedList: subcategoryData.where((element) => element.isSelected).toList().map((e) => e.title).toList(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                      const SizedBox(height: 30),
                      const SearchFilterFields(),
                      const SizedBox(height: 30),
                      ValueListenableBuilder(
                          valueListenable: selectedFeatures,
                          builder: (context, value, child) {
                            return SearchFilterCategoryMobile(
                              onSelect: (value) {
                                if (selectedFeatures.value.contains(value)) {
                                  selectedFeatures.value = {...selectedFeatures.value}..removeWhere((element) => element == value);
                                } else {
                                  selectedFeatures.value = {...selectedFeatures.value, value};
                                }
                              },
                              title: "Features",
                              list: features.value,
                              selectedList: selectedFeatures.value.toList(),
                            );
                          }),
                      const SizedBox(height: 30),
                      ValueListenableBuilder(
                          valueListenable: selectedEligibilities,
                          builder: (context, value, child) {
                            return SearchFilterCategoryMobile(
                              onSelect: (value) {
                                if (selectedEligibilities.value.contains(value)) {
                                  selectedEligibilities.value = {...selectedEligibilities.value}..removeWhere((element) => element == value);
                                } else {
                                  selectedEligibilities.value = {...selectedEligibilities.value, value};
                                }
                              },
                              title: "Eligibility",
                              list: eligibilities.value,
                              selectedList: selectedEligibilities.value.toList(),
                            );
                          }),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: "Apply Filters",
                        width: double.infinity,
                        onTap: () {
                          widget.cubit.fillFilterList(
                            categoryList: categoryList.value,
                            selectedEligibilities: selectedEligibilities.value,
                            selectedFeatures: selectedFeatures.value,
                          );
                          widget.cubit.navigator.navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
