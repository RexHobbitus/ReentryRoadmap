import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_category_popup.dart';

class SearchFilterCategoryWeb extends StatelessWidget {
  final SearchCubit cubit;

  const SearchFilterCategoryWeb({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ...List.generate(
                min(5, state.categoriesList.length),
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            value: state.categoriesList[index].isSelected ?? false,
                            onChanged: (value) => cubit.selectDeselectCategory(category: state.categoriesList[index]),
                            checkColor: Colors.transparent,
                            activeColor: context.colorScheme.secondary,
                            side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.categoriesList[index].title ?? "",
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
              if (state.categoriesList.length > 5) ...[
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    cubit.navigator.navigator.showDialogBox(
                        context,
                        SearchFilterCategoryPopup(
                          list: state.categoriesList,
                          cubit: cubit,
                          onResult: (result) {
                            cubit.handleCategorySelection(result);
                          },
                        ));
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
