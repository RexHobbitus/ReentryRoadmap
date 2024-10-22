
import 'package:reentry_roadmap/data/models/program_category_json.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';

class ProgramJson {
  String? name;
  String? description;
  List<ProgramCategoryJson>? programCategories;
  List<String>? features;
  List<String>? eligibilityCriteria;



  ProgramJson(
      {this.name,
        this.description,
        this.programCategories,
        this.features,
        this.eligibilityCriteria,

      });

  ProgramJson.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['programCategories'] != null) {
      programCategories = <ProgramCategoryJson>[];
      json['programCategories'].forEach((v) {
        programCategories!.add(new ProgramCategoryJson.fromJson(v));
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

  Program toDomain(){
    return Program(
      name: name,
      description: description,
      programCategories: programCategories?.map((category)=>category.toDomain()).toList()??[],
      features: features,
      eligibilityCriteria: eligibilityCriteria
    );
  }
}