
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class AppStyle{

  static TextStyle? webMenuTextStyle(BuildContext context,{bool isSelected=false}){
    return context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: isSelected ? context.colorScheme.primary : null);
  }
}