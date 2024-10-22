import 'package:flutter/cupertino.dart';
import 'package:reentry_roadmap/domain/entities/general_service.dart';
import 'program_category_json.dart';

class GeneralServiceJson {
  List<ProgramCategoryJson>? serviceCategories;
  List<String>? features;
  List<String>? eligibilityCriteria;

  GeneralServiceJson(
      {
        this.serviceCategories,
        this.features,
        this.eligibilityCriteria});

  GeneralServiceJson.fromJson(Map<String, dynamic> json) {
    if (json['serviceCategories'] != null) {
      serviceCategories = <ProgramCategoryJson>[];
      json['serviceCategories'].forEach((v) {
        serviceCategories!.add(new ProgramCategoryJson.fromJson(v));
      });
    }
    features = json['features'].cast<String>();
    eligibilityCriteria = json['eligibilityCriteria'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceCategories != null) {
      data['serviceCategories'] =
          this.serviceCategories!.map((v) => v.toJson()).toList();
    }
    data['features'] = this.features;
    data['eligibilityCriteria'] = this.eligibilityCriteria;
    return data;
  }

  GeneralService toDomain(){
    debugPrint("got categoryes from server ${serviceCategories?.length.toString()}");
    return GeneralService(
      serviceCategories: serviceCategories?.map((category)=>category.toDomain()).toList()??[],
      features: features??[],
      eligibilityCriteria: eligibilityCriteria??[]
    );
  }
}