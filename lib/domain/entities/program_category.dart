class ProgramCategory {
  String? title;
  List<String>? subCategories;

  ProgramCategory({this.title, this.subCategories});

  ProgramCategory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subCategories = json['subCategories'].cast<String>();
  }

  ProgramCategory.shimmer() {
    title = "Testing";
    subCategories = List.generate(2, (index)=>"Testing");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subCategories'] = this.subCategories;
    return data;
  }
}