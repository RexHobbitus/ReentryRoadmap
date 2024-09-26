import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  double get statusBarHeight => MediaQuery.paddingOf(this).top;

  /// screen width
  double get sw => MediaQuery.sizeOf(this).width;

  /// screen height
  double get sh => MediaQuery.sizeOf(this).height;
}
