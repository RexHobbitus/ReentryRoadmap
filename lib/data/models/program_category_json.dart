import 'package:reentry_roadmap/domain/entities/program_category.dart';

class ProgramCategoryJson {
  String? title;
  List<String>? subCategories;

  ProgramCategoryJson({this.title, this.subCategories});

  ProgramCategoryJson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subCategories = json['subCategories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subCategories'] = this.subCategories;
    return data;
  }

  ProgramCategory toDomain() {
    return ProgramCategory(
      title: title,
      subCategories: subCategories,
    );
  }
}
