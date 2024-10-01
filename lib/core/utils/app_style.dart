
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class AppStyle{

  static TextStyle? webMenuTextStyle(BuildContext context,{bool isSelected=false}){
    return context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: isSelected ? context.colorScheme.primary : null);
  }

  static TextStyle? onboardingTitle(BuildContext context){
    return context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
    );
  }
  static TextStyle? onboardingSubTitle(BuildContext context){
    return context.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
      color: context.colorScheme.tertiary,
    );
  }

}