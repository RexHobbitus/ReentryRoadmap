import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  /// Returns the width of the screen
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the height of the screen
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the device pixel ratio
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Returns the padding on top of the screen (usually for status bar)
  double get paddingTop => MediaQuery.of(this).padding.top;

  /// Returns the padding on bottom of the screen (usually for navigation bar)
  double get paddingBottom => MediaQuery.of(this).padding.bottom;

  /// Returns the orientation of the screen
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// Returns the text scale factor of the device
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}
