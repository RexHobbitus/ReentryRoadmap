import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';

class SearchState {
  final bool loading;
  final List<ServiceCategory> categoryList;
  final Set<ServiceCategory> selectedCategoryList;

  const SearchState({
    required this.loading,
    required this.categoryList,
    required this.selectedCategoryList,
  });

  factory SearchState.initial() => SearchState(
        loading: false,
        categoryList: kServiceCategories,
        selectedCategoryList: {},
      );

  SearchState copyWith({
    bool? loading,
    List<ServiceCategory>? categoryList,
    Set<ServiceCategory>? selectedCategoryList,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      categoryList: categoryList ?? this.categoryList,
      selectedCategoryList: selectedCategoryList ?? this.selectedCategoryList,
    );
  }
}
