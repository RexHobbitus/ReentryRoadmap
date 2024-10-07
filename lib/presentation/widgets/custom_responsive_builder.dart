import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

enum DeviceSize { mobile, web }

class CustomResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints, DeviceSize) builder;
  const CustomResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceSize = _getDeviceSize(constraints);
        return builder(context, constraints, deviceSize);
      },
    );
  }

  DeviceSize _getDeviceSize(BoxConstraints constraints) {
    if (constraints.maxWidth <= kMenuBreakPoint) {
      return DeviceSize.mobile;
    } else {
      return DeviceSize.web;
    }
  }
}