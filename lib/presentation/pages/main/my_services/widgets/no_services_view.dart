import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/theme/light_theme.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';

class NoServicesView extends StatelessWidget {
  const NoServicesView({super.key,required this.title,required this.desc});
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.noServices,
            height: 200,
          ),
          Text(
title,

            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isDesktop(context) ? 30 : 20),
          ),
          20.verticalSpace,
          Text(
           desc,

            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isDesktop(context) ? 20 : 15,color: lightSurfaceContainerColor

            ),
          ),
          50.verticalSpace,
        ],
      ),
    );
  }
}
