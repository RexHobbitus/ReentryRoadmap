class AppUser {
  String? id;
  String? name;
  String? email;

  AppUser({this.id, this.name, this.email});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
  AppUser.empty(){
    id = null;
    name = "Dummy username";
    email = "Dummy email";
  }
  bool get isLoggedIn => id!=null;

}
