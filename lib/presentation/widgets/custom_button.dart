import 'package:flutter/material.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize:  Size(width??context.sw, height??50),
              maximumSize:Size(width??context.sw, height??57),
              textStyle: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: isDisabled
                  ? context.colorScheme.tertiary
                  : isSecondary
                      ? context.themeData.colorScheme.secondary
                      : null,
              // Set the disabled background color
              foregroundColor: isDisabled
                  ? context.colorScheme.surface
                  : isSecondary
                      ?  context.themeData.colorScheme.onSecondary
                      : null, // Set the disabled text color
            ),
            onPressed: isDisabled ? (){} : onTap,
            iconAlignment: IconAlignment.end,
            icon: iconData==null?null:Icon(iconData,color:
            context.colorScheme.onPrimary,size: 15,),
            label: Text(text ?? "",),
          );
  }
}
