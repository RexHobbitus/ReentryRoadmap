import 'package:flutter/material.dart';

class Responsive {
  // Define breakpoints
  static const int mobileBreakpoint = 600;
  static const int tabletBreakpoint = 1024;

  // Static getter to check if the screen is mobile-sized
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  // Static getter to check if the screen is less than desktop-sized
  static bool isLessThanDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;

  // Static getter to check if the screen is tablet-sized
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
          MediaQuery.of(context).size.width < tabletBreakpoint;

  // Static getter to check if the screen is desktop-sized
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;
}
