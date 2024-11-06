import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/data/models/categories_json.dart';
import 'package:reentry_roadmap/domain/entities/organization.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

class SearchState {
  final bool loading;
  final bool listLoading;
  final bool isShowEligibleProvider;
  final String selectedCategory;
  final List<Provider> services;
  final List<Provider> paginatedServices;
  final List<String> subCategories;
  final List<String> eligibilities;
  final Set<String> selectedEligibilities;
  final List<String> features;
  final Set<String> selectedFeatures;
  final List<CategoryData> categoriesList;
  final int currentPage;
  final int totalPage;
  final List pageShowcaseList;
  final List<OrganizationData> organizationList;

  const SearchState({
    required this.loading,
    required this.listLoading,
    required this.isShowEligibleProvider,
    required this.selectedCategory,
    this.services = const [],
    this.paginatedServices = const [],
    this.eligibilities = const [],
    this.features = const [],
    this.categoriesList = const [],
    this.subCategories = const [],
    this.selectedFeatures = const {},
    this.selectedEligibilities = const {},
    required this.currentPage,
    this.totalPage = 0,
    this.pageShowcaseList = const [],
    this.organizationList = const [],
  });

  factory SearchState.initial() => SearchState(
      loading: false,
      listLoading: false,
      isShowEligibleProvider: false,
      selectedCategory: "",
      categoriesList: kServiceCategories.map((e) => CategoryData(title: e.title)).toList(),
      features: kProgramFeatures,
      eligibilities: kEligibilityCriteria,
      currentPage: 1);

  SearchState copyWith({
    bool? loading,
    bool? listLoading,
    bool? isShowEligibleProvider,
    String? selectedCategory,
    List<Provider>? services,
    List<Provider>? paginatedServices,
    List<String>? subCategories,
    List<String>? eligibilities,
    Set<String>? selectedEligibilities,
    List<String>? features,
    Set<String>? selectedFeatures,
    List<CategoryData>? categoriesList,
    int? currentPage,
    int? totalPage,
    List? pageShowcaseList,
    List<OrganizationData>? organizationList,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      listLoading: listLoading ?? this.listLoading,
      isShowEligibleProvider: isShowEligibleProvider ?? this.isShowEligibleProvider,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      services: services ?? this.services,
      paginatedServices: paginatedServices ?? this.paginatedServices,
      subCategories: subCategories ?? this.subCategories,
      eligibilities: eligibilities ?? this.eligibilities,
      selectedEligibilities: selectedEligibilities ?? this.selectedEligibilities,
      features: features ?? this.features,
      selectedFeatures: selectedFeatures ?? this.selectedFeatures,
      categoriesList: categoriesList ?? this.categoriesList,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      pageShowcaseList: pageShowcaseList ?? this.pageShowcaseList,
      organizationList: organizationList ?? this.organizationList,
    );
  }
}
