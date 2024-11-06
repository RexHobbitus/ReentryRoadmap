class OrganizationData {
  String? orgDescription;
  List<Category>? categories;
  String? orgId;
  String? orgName;

  OrganizationData({
    this.orgDescription,
    this.categories,
    this.orgId,
    this.orgName,
  });

  factory OrganizationData.fromJson(Map<String, dynamic> json) => OrganizationData(
    orgDescription: json["orgDescription"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    orgId: json["orgId"],
    orgName: json["orgName"],
  );

  Map<String, dynamic> toJson() => {
    "orgDescription": orgDescription,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "orgId": orgId,
    "orgName": orgName,
  };
}

class Category {
  String? title;
  List<String>? subCategories;

  Category({
    this.title,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    title: json["title"],
    subCategories: json["subCategories"] == null ? [] : List<String>.from(json["subCategories"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x)),
  };
}
