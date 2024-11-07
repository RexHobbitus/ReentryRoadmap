import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/domain/entities/organization.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/repositories/database/organization_repository.dart';
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
  OrganizationRepository organizationRepository;
  RoadmapSettingsRepository roadmapSettingsRepository;

  SearchCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.providerRepository,
    required this.organizationRepository,
    required this.roadmapSettingsRepository,
  }) : super(SearchState.initial());

  BuildContext get context => navigator.context;

  int get pageLimit => 10;

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController minDistanceController = TextEditingController();
  TextEditingController maxDistanceController = TextEditingController();
  double? lat;
  double? long;
  Timer? _timer;

  onInit(SearchInitialParams initialParams) {
    print("initialParams===>${initialParams.selectedCategory}");
    emit(state.copyWith(selectedCategory: initialParams.selectedCategory));
    _getServices();
    _getCategories();
    _getCurrentLocation();
  }

  void toggleShowEligibleProvider(bool value) {
    emit(state.copyWith(isShowEligibleProvider: value));
    _getServices();
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
        selectedCategory: "",
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
    _getServices();
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
    _getServices();
  }

  _getServices() async {
    try {
      emit(state.copyWith(listLoading: true));
      List<Provider> services = await providerRepository.getSearchPageServices(
        categories: state.categoriesList,
        particularServiceSelected: state.selectedCategory,
        eligibility: state.selectedEligibilities.toList(),
        features: state.selectedFeatures.toList(),
        showOnlyEligibleProvider: state.isShowEligibleProvider,
        searchText: searchController.text,
        locationText: locationController.text,
        lat: lat,
        long: long,
        minDistance: minDistanceController.text.isEmpty ? null : double.parse(minDistanceController.text),
        maxDistance: maxDistanceController.text.isEmpty ? null : double.parse(maxDistanceController.text),
      );
      await _getOrganizationData(
          organizationIds: services
              .map(
                (e) => e.orgId ?? "",
              )
              .toList()
              .toSet()
              .toList());
      emit(state.copyWith(services: services));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(listLoading: false, currentPage: 1, totalPage: (state.services.length / pageLimit).ceil()));
      handlePagination(page: state.currentPage, isInitial: true);
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
    minDistanceController.clear();
    maxDistanceController.clear();
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
    _getServices();
  }

  void handleFeaturesSelection(List<String> result) {
    emit(state.copyWith(selectedFeatures: result.toSet()));
    _getServices();
  }

  void handleEligibilitySelection(List<String> result) {
    emit(state.copyWith(selectedEligibilities: result.toSet()));
    _getServices();
  }

  Future<void> _getCategories() async {
    try {
      emit(state.copyWith(loading: true));

      List<CategoryData>? categoriesList = await roadmapSettingsRepository.getCategories();

      List<String>? eligibilitiesList = await roadmapSettingsRepository.getEligibilities();

      List<String>? featuresList = await roadmapSettingsRepository.getFeatures();

      if (state.selectedCategory.isNotEmpty) {
        final index = state.categoriesList.indexWhere((e) => e.title == state.selectedCategory);
        final category = categoriesList[index].copyWith(isSelected: true);
        if (!index.isNegative) {
          categoriesList = [...categoriesList]
            ..removeAt(index)
            ..insert(index, category);
        }
      }

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
    _getServices();
  }

  void handlePagination({required int page, bool isInitial = false}) {
    if (state.services.isEmpty) {
      emit(state.copyWith(
        paginatedServices: [],
        currentPage: 1,
        pageShowcaseList: [1],
      ));
    }

    if ((!isInitial && page < 1) || page > state.totalPage) return;

    int startIndex = (page - 1) * pageLimit;
    int endIndex = min(page * pageLimit, state.services.length);

    List<Provider> paginatedList = state.services.sublist(startIndex, endIndex);

    emit(state.copyWith(
      paginatedServices: paginatedList,
      currentPage: page,
      pageShowcaseList: _generatePagination(page, state.totalPage),
    ));
    if (!isInitial) {
      scrollController.animateTo(scrollController.position.minScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  List<int> _generatePagination(int currentPage, int totalPages) {
    if (totalPages <= 5) {
      return List<int>.generate(totalPages, (index) => index + 1);
    }

    if (currentPage <= 3) {
      return [1, 2, 3, 4, 5];
    }

    if (currentPage >= totalPages - 2) {
      return [totalPages - 4, totalPages - 3, totalPages - 2, totalPages - 1, totalPages];
    }

    return [currentPage - 2, currentPage - 1, currentPage, currentPage + 1, currentPage + 2];
  }

  void onSearch() {
    resetFilters();
  }

  Future<void> _getOrganizationData({required List<String> organizationIds}) async {
    if (state.organizationList.isNotEmpty) return;
    organizationIds.removeWhere(
      (element) => element == "",
    );
    List<OrganizationData> result = await organizationRepository.getSetViseOrganization(organizationSet: organizationIds);
    emit(state.copyWith(organizationList: result));
  }

  Future<void> _getCurrentLocation() async {
    if (await _checkPermission(context: context, permission: kIsWeb ? Permission.location : Permission.locationWhenInUse)) {
      await _getCurrentLatLong();
    }
  }

  Future<void> _getCurrentLatLong() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      long = position.longitude;
    } on Exception catch (e) {
      debugPrint("field to get current location: $e");
    }
  }

  Future<bool> _checkPermission({required BuildContext context, required Permission permission}) async {
    final status = await permission.status;
    switch (status) {
      case PermissionStatus.denied:
        return await permission.request().isGranted;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        return false;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.permanentlyDenied:
        if (context.mounted) {
          // PermissionDialog.show(context: context, type: permission.toString());
        }
        return false;
      case PermissionStatus.provisional:
        return false;
    }
  }

  void handleMileFilter() {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(
      const Duration(seconds: 1),
      () {
        if (lat != null && long != null) {
          _getServices();
        }
        _timer?.cancel();
        _timer = null;
      },
    );
  }
}
