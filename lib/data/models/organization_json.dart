import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/models/program_category_json.dart';

class OrganizationJson {
  String? orgId;
  String? orgName;
  String? orgDescription;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<ProgramCategoryJson>? categories;

  OrganizationJson({
    this.orgId,
    this.orgName,
    this.orgDescription,
    this.createdAt,
    this.updatedAt,
  });

  OrganizationJson.fromJson(Map<String, dynamic> json) {
    orgId = json['orgId'];
    orgName = json['orgName'];
    orgDescription = json['orgDescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['categories'] != null) {
      categories = <ProgramCategoryJson>[];
      json['categories'].forEach((v) {
        categories!.add(ProgramCategoryJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orgId'] = orgId;
    data['orgName'] = orgName;
    data['orgDescription'] = orgDescription;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
