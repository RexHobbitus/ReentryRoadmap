import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class SearchFilterSubCategoryPopup extends StatefulWidget {
  final SearchCubit cubit;
  final List<SubCategoryData> selectedSubCategoryList;
  final List<CategoryData> selectedCategoryList;
  final void Function(List<SubCategoryData> result) onResult;

  const SearchFilterSubCategoryPopup({
    super.key,
    required this.cubit,
    required this.selectedSubCategoryList,
    required this.selectedCategoryList,
    required this.onResult,
  });

  @override
  State<SearchFilterSubCategoryPopup> createState() => _SearchFilterSubCategoryPopupState();
}

class _SearchFilterSubCategoryPopupState extends State<SearchFilterSubCategoryPopup> {
  ValueNotifier<List<SubCategoryData>> locallySelectedSubcategory = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    locallySelectedSubcategory.value = widget.selectedSubCategoryList;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomResponsiveBuilder(
      builder: (context, constraints, deviceSize) {
        return Container(
          width: deviceSize == DeviceSize.web ? 600 : null,
          constraints: BoxConstraints(maxHeight: size.height * .8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subcategories",
                    style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  CloseButton(
                    style: IconButton.styleFrom(
                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: locallySelectedSubcategory,
                  builder: (context, selectedValue, child) {
                    return Flexible(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, listIndex) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.selectedCategoryList[listIndex].title ?? "",
                                  style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Flexible(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.selectedCategoryList[listIndex].subCategories?.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 40,
                                    ),
                                    itemBuilder: (context, index) {
                                      final subCategory = widget.selectedCategoryList[listIndex].subCategories?[index];
                                      return Row(
                                        children: [
                                          SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: Checkbox(
                                              hoverColor: Colors.transparent,
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              value: selectedValue.contains(subCategory),
                                              onChanged: (value) {
                                                if (selectedValue.contains(subCategory)) {
                                                  locallySelectedSubcategory.value = [...locallySelectedSubcategory.value]
                                                    ..removeWhere((element) => element == subCategory);
                                                } else {
                                                  if (subCategory != null) {
                                                    locallySelectedSubcategory.value = [...locallySelectedSubcategory.value, subCategory];
                                                  }
                                                }
                                              },
                                              checkColor: Colors.transparent,
                                              activeColor: context.colorScheme.secondary,
                                              side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.5)),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              subCategory?.title ?? "",
                                              style: context.textTheme.labelMedium?.copyWith(
                                                color: context.colorScheme.onSurface.withOpacity(0.5),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemCount: widget.selectedCategoryList.length),
                    );
                  }),
              const SizedBox(height: 10),
              CustomButton(
                height: 60,
                width: double.infinity,
                text: "Select",
                onTap: () {
                  widget.onResult.call(locallySelectedSubcategory.value);
                  widget.cubit.navigator.navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
