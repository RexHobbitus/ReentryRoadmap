import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_eligibility_feature_filter_popup.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_feature_eligibility_filter_web.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_category_web.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_fields.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_filter_sub_category_web.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchWebFilterCategories extends StatefulWidget {
  final SearchCubit cubit;

  const SearchWebFilterCategories({
    super.key,
    required this.cubit,
  });

  @override
  State<SearchWebFilterCategories> createState() => _SearchWebFilterCategoriesState();
}

class _SearchWebFilterCategoriesState extends State<SearchWebFilterCategories> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        bloc: widget.cubit,
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.loading,
            ignorePointers: true,
            child: Column(
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
                      onPressed: widget.cubit.resetFilters,
                      child: const Text("Reset"),
                      // style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SearchFilterCategoryWeb(cubit: widget.cubit),
                if (state.categoriesList.where((element) => element.isSelected ?? false).toList().isNotEmpty) ...[
                  const SizedBox(height: 30),
                  SearchFilterSubCategoryWeb(cubit: widget.cubit),
                ],
                const SizedBox(height: 30),
                const SearchFilterFields(),
                const SizedBox(height: 30),
                SearchFeatureEligibilityFilterWeb(
                  title: "Features",
                  list: state.features,
                  selectedList: state.selectedFeatures.toList(),
                  onSelect: (index) => widget.cubit.selectDeselectFeatures(state.features[index]),
                  onMore: () {
                    widget.cubit.navigator.navigator.showDialogBox(
                        context,
                        SearchEligibilityFeatureFilterPopup(
                          title: "Features",
                          list: state.features,
                          selectedList: state.selectedFeatures.toList(),
                          onResult: (result) {
                            widget.cubit.handleFeaturesSelection(result);
                          },
                          cubit: widget.cubit,
                        ));
                  },
                ),
                const SizedBox(height: 30),
                SearchFeatureEligibilityFilterWeb(
                  title: "Eligibility",
                  list: state.eligibilities,
                  selectedList: state.selectedEligibilities.toList(),
                  onSelect: (index) => widget.cubit.selectDeselectEligibilities(state.eligibilities[index]),
                  onMore: () {
                    widget.cubit.navigator.navigator.showDialogBox(
                        context,
                        SearchEligibilityFeatureFilterPopup(
                          title: "Eligibility",
                          list: state.eligibilities,
                          selectedList: state.selectedEligibilities.toList(),
                          onResult: (result) {
                            widget.cubit.handleEligibilitySelection(result);
                          },
                          cubit: widget.cubit,
                        ));
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        });
  }
}
