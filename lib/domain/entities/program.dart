import 'package:reentry_roadmap/domain/entities/program_category.dart';

class Program {
  String? name;
  String? description;
  List<ProgramCategory>? programCategories;
  List<String>? features;
  List<String>? eligibilityCriteria;

  Program(
      {this.name,
        this.description,
        this.programCategories,
        this.features,
        this.eligibilityCriteria});

  Program.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['programCategories'] != null) {
      programCategories = <ProgramCategory>[];
      json['programCategories'].forEach((v) {
        programCategories!.add(new ProgramCategory.fromJson(v));
      });
    }
    features = json['features'].cast<String>();
    eligibilityCriteria = json['eligibilityCriteria'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.programCategories != null) {
      data['programCategories'] =
          this.programCategories!.map((v) => v.toJson()).toList();
    }
    data['features'] = this.features;
    data['eligibilityCriteria'] = this.eligibilityCriteria;
    return data;
  }
}