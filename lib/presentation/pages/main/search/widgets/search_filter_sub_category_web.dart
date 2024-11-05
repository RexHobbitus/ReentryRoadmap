import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_state.dart';

class SearchFilterSubCategoryWeb extends StatelessWidget {
  final SearchCubit cubit;

  const SearchFilterSubCategoryWeb({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          final selectedCategory = state.categoriesList.where((element) => element.isSelected ?? false).toList();
          int length = 0;
          for (var element in selectedCategory) {
            length = length + (element.subCategories?.length ?? 0);
          }
          int totalLength = 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Subcategory",
                style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ...List.generate(
                min(5, selectedCategory.length),
                (index) {
                  final subCategories = selectedCategory[index].subCategories ?? [];
                  if (totalLength < 5) {
                    totalLength = totalLength + subCategories.length;
                  } else {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: List.generate(
                      totalLength > 5 ? (5 - (totalLength - subCategories.length)) : subCategories.length,
                      (subCategoryIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: Checkbox(
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  value: subCategories[subCategoryIndex].isSelected,
                                  onChanged: (value) => cubit.selectDeselectSubCategory(
                                      value: subCategories[subCategoryIndex].title, category: selectedCategory[index].title ?? ""),
                                  checkColor: Colors.transparent,
                                  activeColor: context.colorScheme.secondary,
                                  side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.5)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  subCategories[subCategoryIndex].title,
                                  style: context.textTheme.labelMedium?.copyWith(
                                    color: context.colorScheme.onSurface.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (length > 5) ...[
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    // widget.cubit.navigator.navigator.showDialogBox(
                    //     context,
                    //     SearchFilterSubCategoryPopup(
                    //       cubit: widget.cubit,
                    //       selectedCategoryList: state.selectedCategoryList.toList(),
                    //       selectedSubCategoryList: state.selectedSubCategories.toList(),
                    //       onResult: (result) {
                    //         widget.cubit.handleSubCategorySelection(result);
                    //       },
                    //     ));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 16,
                        color: context.colorScheme.onSurface.withOpacity(0.5),
                      ),
                      Text(
                        "More",
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.onSurface.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                )
              ]
            ],
          );
        });
  }
}
