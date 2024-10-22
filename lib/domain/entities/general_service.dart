import 'package:reentry_roadmap/domain/entities/program_category.dart';

class GeneralService{
  List<ProgramCategory>? serviceCategories;
  List<String>? features;
  List<String>? eligibilityCriteria;

  GeneralService(
      {
        this.serviceCategories,
        this.features,
        this.eligibilityCriteria});

  GeneralService.fromJson(Map<String, dynamic> json) {
    if (json['serviceCategories'] != null) {
      serviceCategories = <ProgramCategory>[];
      json['serviceCategories'].forEach((v) {
        serviceCategories!.add(new ProgramCategory.fromJson(v));
      });
    }
    features = json['features'].cast<String>();
    eligibilityCriteria = json['eligibilityCriteria'].cast<String>();
  }

  GeneralService.shimmer() {
    serviceCategories=List.generate(2, (index)=>ProgramCategory.shimmer());
    features = List.generate(5, (index)=>"Testing");
    eligibilityCriteria = List.generate(5, (index)=>"Testing");
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
}