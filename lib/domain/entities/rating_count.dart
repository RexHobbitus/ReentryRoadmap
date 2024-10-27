import 'package:equatable/equatable.dart';

class RatingCount extends Equatable{
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;

  RatingCount({this.i1, this.i2, this.i3, this.i4, this.i5});

  RatingCount.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
  }
  RatingCount.shimmer() {
    i1 = 5;
    i2 = 5;
    i3 =5;
    i4 = 5;
    i5 =5;
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

  @override
  // TODO: implement props
  List<Object?> get props => [i1,i2,i3,i4,i5];
}