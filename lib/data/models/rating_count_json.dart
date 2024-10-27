import 'package:reentry_roadmap/domain/entities/rating_count.dart';

class RatingCountJson {
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;

  RatingCountJson({this.i1, this.i2, this.i3, this.i4, this.i5});

  RatingCountJson.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.i1;
    data['2'] = this.i2;
    data['3'] = this.i3;
    data['4'] = this.i4;
    data['5'] = this.i5;
    return data;
  }

  RatingCount toDomain() {
    return RatingCount(
      i1: i1 ?? 0,
      i2: i2 ?? 0,
      i3: i3 ?? 0,
      i4: i4 ?? 0,
      i5: i5 ?? 0,
    );
  }
}
