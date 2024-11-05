import 'package:equatable/equatable.dart';

class CategoryJson {
  List<CategoryData>? categories;

  CategoryJson({
    this.categories,
  });

  CategoryJson.fromJson(Map<String, dynamic> json) {
    categories = (json['categories'] as List<Map<String, dynamic>>).map((e) => CategoryData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = categories;
    return data;
  }
}

class CategoryData extends Equatable {
  String? title;
  List<SubCategoryData>? subCategories;
  bool? isSelected;

  CategoryData({
    this.title,
    this.subCategories,
    this.isSelected,
  });

  @override
  List<Object?> get props => [title, subCategories];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subCategories'] = subCategories;
    return data;
  }

  CategoryData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subCategories = (json['subCategories'] as List).map((e) => SubCategoryData(title: e.toString())).toList();
  }

  CategoryData copyWith({
    String? title,
    List<SubCategoryData>? subCategories,
    bool? isSelected,
  }) {
    return CategoryData(
      title: title ?? this.title,
      subCategories: subCategories ?? this.subCategories,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class SubCategoryData extends Equatable {
  final String title;
  final bool isSelected;

  const SubCategoryData({
    required this.title,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [title];

  SubCategoryData copyWith({
    String? title,
    bool? isSelected,
  }) {
    return SubCategoryData(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
