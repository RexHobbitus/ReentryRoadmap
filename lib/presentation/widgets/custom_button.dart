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


  const CustomButton({
    super.key,
    this.onTap,
    this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.isSecondary = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize:  Size(width??context.sw, height??50),
              maximumSize:Size(width??context.sw, height??57),
              backgroundColor: isDisabled
                  ? Colors.grey.shade300
                  : isSecondary
                      ? context.themeData.colorScheme.secondary
                      : null,
              // Set the disabled background color
              foregroundColor: isDisabled
                  ? Colors.grey.shade500
                  : isSecondary
                      ?  context.themeData.colorScheme.onSecondary
                      : null, // Set the disabled text color
            ),
            onPressed: isDisabled ? null : onTap,
            child: Text(text ?? ""),
          );
  }
}
