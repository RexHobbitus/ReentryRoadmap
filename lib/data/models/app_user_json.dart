/*
1) THIS MODEL CLASS IS ACCORDING TO DATA COMING FROM SERVER SIDE, EITHER FIREBASE OR RESTAPI JSON
2) WE WILL FIRST CONVERT OUR JSON COMING FROM SERVER TO THIS MODEL_JSON
3) THEN THIS MODEL_JSON WILL BE CONVERTED TO MODEL(entity) BY USING toDomain() method.
4) THAT MODEL WILL BE USED BY OUR UI

Steps
var userData => {"id:"123,"name":"test","email:"test@email.com",} => JSON got from server/db
var appUserJson => AppUserJson.fromJson(userData); => Convert server json data to exact same model class
var appUser=appUserJson.toDomain() => Then convert server response data model class to entity class=> This entity model will be used by UI
 */

import 'package:reentry_roadmap/domain/entities/app_user.dart';

class AppUserJson {
  String? id;
  String? name;
  String? email;

  AppUserJson({this.id, this.name, this.email});

  AppUserJson.fromJson(Map<String, dynamic> json) {
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

  AppUser toDomain() {
    return AppUser(
      id: id??"",
      name: name??"N/A",
      email: email??"N/A",
    );
  }
}
