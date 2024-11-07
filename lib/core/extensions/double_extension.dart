import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



  extension DoubleExtension on num {
  // double get flexibleHeight => ScreenUtil().setHeight(this);
  //  double get flexibleWidth => ScreenUtil().setWidth(this);
  // double get fontSize => ScreenUtil().setSp(this);
  // double get screenW => ScreenUtil().screenWidth ;
  // double get screenH => ScreenUtil().screenHeight;
  // double get radius => ScreenUtil().radius(this);

  // Use to add horizontal space
  SizedBox get horizontalSpace => SizedBox(width: convertToDouble(this));
  //
  // SizedBox get responsiveHorizontalSpace =>
  //     SizedBox(width: convertToDouble(this).w);
  //
  // SizedBox get responsiveVerticalSpace =>
  //     SizedBox(height: convertToDouble(this).h);

  // Use to add vertical space
  SizedBox get verticalSpace => SizedBox(height: convertToDouble(this));
}

double convertToDouble(num value) {
  return double.parse(value.toString());
}
