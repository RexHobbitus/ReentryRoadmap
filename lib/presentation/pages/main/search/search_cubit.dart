import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/roadmap_settings_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import 'search_initial_params.dart';
import 'search_navigator.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchNavigator navigator;
  UserStore userStore;
  AppSnackBar snackBar;
  ProviderRepository providerRepository;
  RoadmapSettingsRepository roadmapSettingsRepository;

  SearchCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.providerRepository,
    required this.roadmapSettingsRepository,
  }) : super(SearchState.initial());

  BuildContext get context => navigator.context;

  onInit(SearchInitialParams initialParams) {
    _getServices();
    _getCategories();
  }

  void toggleShowEligibleProvider(bool value) {
    emit(state.copyWith(isShowEligibleProvider: value));
  }

  void selectSingleCategory(String title) {
    resetFilters();
    emit(state.copyWith(selectedCategory: title));
    _getServices();
  }

  selectDeselectCategory({required CategoryData category, bool reload = true}) {
    CategoryData categoryData = category.copyWith(isSelected: !(category.isSelected ?? false));
    final index = state.categoriesList.indexWhere((element) => element.title == categoryData.title);
    if (index == -1) return;
    if (categoryData.isSelected == false) {
      List<SubCategoryData> subCategoryList = categoryData.subCategories?.map((e) => e.copyWith(isSelected: false)).toList() ?? [];
      categoryData = categoryData.copyWith(subCategories: subCategoryList);
    }

    emit(state.copyWith(
        categoriesList: [...state.categoriesList]
          ..removeAt(index)
          ..insert(index, categoryData)));
    if (reload) {
      _getServices();
    }
  }

  selectDeselectSubCategory({required String value, required String category}) {
    final categoryIndex = state.categoriesList.indexWhere((element) => element.title == category);
    if (categoryIndex == -1) return;
    CategoryData categoryData = state.categoriesList[categoryIndex];
    categoryData = categoryData.copyWith(
        subCategories: categoryData.subCategories?.map((e) => e.title == value ? e.copyWith(isSelected: !e.isSelected) : e).toList());

    emit(state.copyWith(
        categoriesList: [...state.categoriesList]
          ..removeAt(categoryIndex)
          ..insert(categoryIndex, categoryData)));

    _getServices();
  }

  selectDeselectFeatures(String value) {
    Set<String> selectedSet = state.selectedFeatures;
    if (selectedSet.contains(value)) {
      selectedSet = {...selectedSet}..remove(value);
      selectedSet.remove(value);
    } else {
      selectedSet = {...selectedSet, value};
    }
    emit(state.copyWith(selectedFeatures: selectedSet));
  }

  selectDeselectEligibilities(String value) {
    Set<String> selectedSet = state.selectedEligibilities;
    if (selectedSet.contains(value)) {
      selectedSet = {...selectedSet}..remove(value);
      selectedSet.remove(value);
    } else {
      selectedSet = {...selectedSet, value};
    }
    emit(state.copyWith(selectedEligibilities: selectedSet));
  }

  _getServices() async {
    try {
      emit(state.copyWith(listLoading: true));
      List<Provider> services = await providerRepository.getSearchPageServices(
        categories: state.categoriesList,
        particularServiceSelected: state.selectedCategory,
      );
      emit(state.copyWith(services: services));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(listLoading: false));
    }
  }

  void resetFilters() {
    List<CategoryData> categoryList = [];
    for (var element in state.categoriesList) {
      categoryList.add(
        element.copyWith(
          isSelected: false,
          subCategories: element.subCategories?.map((e) => e.copyWith(isSelected: false)).toList(),
        ),
      );
    }
    emit(state.copyWith(selectedEligibilities: {}, selectedFeatures: {}, categoriesList: categoryList));
    _getServices();
  }

  void handleCategorySelection(List<CategoryData> result) {
    List<CategoryData> selectedCategoryList = state.categoriesList.where((element) => element.isSelected ?? false).toList();
    List<CategoryData> tempResult = List.from(result);
    for (var element in result) {
      final contains = selectedCategoryList.where((element) => element.title == element.title).isNotEmpty;
      if (contains) {
        tempResult.removeWhere((category) => category.title == element.title);
        selectedCategoryList.removeWhere((category) => category.title == element.title);
      }
    }
    for (var ele in <dynamic>{...tempResult, ...selectedCategoryList}.toList()) {
      selectDeselectCategory(category: ele, reload: false);
    }
  }

  void handleFeaturesSelection(List<String> result) {
    emit(state.copyWith(selectedFeatures: result.toSet()));
  }

  void handleEligibilitySelection(List<String> result) {
    emit(state.copyWith(selectedEligibilities: result.toSet()));
  }

  Future<void> _getCategories() async {
    try {
      emit(state.copyWith(loading: true));

      List<CategoryData>? categoriesList = await roadmapSettingsRepository.getCategories();

      List<String>? eligibilitiesList = await roadmapSettingsRepository.getEligibilities();

      List<String>? featuresList = await roadmapSettingsRepository.getFeatures();

      emit(state.copyWith(eligibilities: eligibilitiesList, features: featuresList, categoriesList: categoriesList));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void fillFilterList({
    required List<CategoryData> categoryList,
    required Set<String> selectedFeatures,
    required Set<String> selectedEligibilities,
  }) {
    emit(state.copyWith(
      selectedFeatures: selectedFeatures,
      selectedEligibilities: selectedEligibilities,
      categoriesList: categoryList,
    ));
  }

// void handleSubCategorySelection(List<String> result) {
//   emit(state.copyWith(selectedSubCategories: result.toSet()));
// }
}
