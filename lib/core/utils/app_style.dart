import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class AppStyle {
  static TextStyle? webMenuTextStyle(BuildContext context,
      {bool isSelected = false}) {
    return context.textTheme.bodyMedium?.copyWith(
        color: isSelected ? context.colorScheme.primary : null);
  }

  static TextStyle? onboardingTitle(BuildContext context) {
    return context.textTheme.titleMedium?.copyWith(
      color: context.colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle? hintStyle(BuildContext context) {
    return context.textTheme.bodyLarge?.copyWith(
      color: context.colorScheme.tertiary,
    );
  }

  static TextStyle? textFieldTextStyle(BuildContext context) {
    return context.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      color: context.colorScheme.onSurface,
    );
  }

  static TextStyle? onboardingSubTitle(BuildContext context) {
    return context.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: context.colorScheme.tertiary,
    );
  }

  static TextStyle? providerDetailTitle(BuildContext context) {
    return context.textTheme.titleMedium;
  }

  static TextStyle? providerDetailUnderlinedSubTitle(BuildContext context) {
    return context.textTheme.bodyLarge?.copyWith(
        decoration: TextDecoration.underline);
  }

  static TextStyle? providerDetailBody(BuildContext context) {
    return context.textTheme.bodyLarge;
  }

  static InputDecoration textFieldDecoration(
    BuildContext context, {
    String? label,
    String? hint,
    TextFieldMode textFieldMode = TextFieldMode.normal,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintStyle: context.textTheme.bodyMedium
          ?.copyWith(color: context.themeData.colorScheme.tertiary),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: hint,
      hintFadeDuration: const Duration(milliseconds: 500),
      isDense: true,
      filled: textFieldMode == TextFieldMode.normal ? false : true,
      hoverColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      fillColor: context.themeData.cardColor,
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 30,
      ),
      enabledBorder: _borderStyle(context),
      focusedBorder: _borderStyle(context),
    );
  }

  static _borderStyle(
    BuildContext context, {
    TextFieldMode textFieldMode = TextFieldMode.normal,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
          textFieldMode == TextFieldMode.normal ? 10 : 30),
      borderSide: BorderSide(
        color: textFieldMode == TextFieldMode.normal
            ? context.colorScheme.tertiaryContainer
            : Colors.transparent,
        width: 1.5,
      ),
    );
  }
}
