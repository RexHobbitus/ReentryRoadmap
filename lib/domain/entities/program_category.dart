class ProgramCategory {
  String? title;
  List<String>? subCategories;

  ProgramCategory({this.title, this.subCategories});

  ProgramCategory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subCategories = json['subCategories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subCategories'] = this.subCategories;
    return data;
  }
}