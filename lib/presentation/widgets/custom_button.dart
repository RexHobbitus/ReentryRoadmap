import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/extensions/theme_extension.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final bool isDisabled;
  final bool isLoading;
  final bool isSecondary;
  final double? width;
  final double? height;
  final IconData? iconData;
  final String? iconPath;
  final IconAlignment? iconAlignment;
  final double? radius;
  final TextStyle? style;

  const CustomButton({
    super.key,
    this.onTap,
    this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.isSecondary = false,
    this.iconData,
    this.height,
    this.width,
    this.iconPath,
    this.iconAlignment,
    this.radius,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 10), // <-- Radius
              ),
              minimumSize: Size(width ?? context.sw, height ?? 50),
              maximumSize: Size(width ?? context.sw, height ?? 57),
              textStyle: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: isDisabled
                  ? context.colorScheme.tertiary
                  : isSecondary
                      ? context.themeData.colorScheme.secondaryFixed
                      : null,
              // Set the disabled background color
              foregroundColor: isDisabled
                  ? context.colorScheme.surface
                  : isSecondary
                      ? context.themeData.colorScheme.onSecondaryFixed
                      : null, // Set the disabled text color
            ),
            onPressed: isDisabled ? () {} : onTap,
            iconAlignment: iconPath != null
                ? IconAlignment.start
                : iconAlignment ?? IconAlignment.end,
            icon: iconData == null
                ? iconPath != null
                    ? SvgPicture.asset(iconPath!)
                    : null
                : Icon(
                    iconData,
                    color: context.colorScheme.onPrimary,
                    size: 15,
                  ),
            label: Text(text ?? "",
                style: style?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ) ??
                    context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                    )),
          );
  }
}
