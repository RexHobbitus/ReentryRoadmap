import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  Responsive._();

  // Define breakpoints
  static const int mobileBreakpoint = 600;
  static const int tabletBreakpoint = 768;
  static const int largeTabletBreakpoint = 1024;
  static const int desktopBreakpoint = 1280;

  // Static getter to check if the screen is mobile-sized
  static bool isMobile(BuildContext context) =>
      ScreenUtil().screenWidth < tabletBreakpoint;

  // // Static getter to check if the screen is less than desktop-sized
  // static bool isLessThanDesktop(BuildContext context) =>
  //     ScreenUtil().screenWidth > tabletBreakpoint &&
  //     ScreenUtil().screenWidth <= tabletBreakpoint;
  //
  // static bool isLessThanTablet(BuildContext context) =>
  //     ScreenUtil().screenWidth < tabletBreakpoint;

  // Static getter to check if the screen is tablet-sized
  static bool isTablet(BuildContext context) =>
      ScreenUtil().screenWidth > mobileBreakpoint &&
      ScreenUtil().screenWidth < largeTabletBreakpoint;

  static bool isLargeTablet(BuildContext context) =>
      ScreenUtil().screenWidth > tabletBreakpoint &&
      ScreenUtil().screenWidth < desktopBreakpoint;

  // Static getter to check if the screen is desktop-sized
  static bool isDesktop(BuildContext context) {
    return ScreenUtil().screenWidth >= desktopBreakpoint;
  }

  static int getResponsiveValue(context, int mobile, int tablet, int desktop,
      {int? largeTablet}) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else if (isLargeTablet(context)) {
      return largeTablet ?? tablet;
    } else {
      return desktop;
    }
  }

  static double getResponsiveValueDouble(
      context, double mobile, double tablet, double desktop,
      {double? largeTablet}) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else if (isLargeTablet(context)) {
      return largeTablet ?? tablet;
    } else {
      return desktop;
    }
  }
}
