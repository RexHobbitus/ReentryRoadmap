import 'package:flutter/material.dart';
 import '../../../core/extensions/theme_extension.dart';
class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final bool isDisabled;
  final bool isLoading;
  final bool isSecondary;

  const CustomButton({
    super.key,
    this.onTap,
    this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 45),
              backgroundColor: isDisabled
                  ? Colors.grey.shade300
                  : isSecondary
                      ? context.colorTheme.surface
                      : null,
              // Set the disabled background color
              foregroundColor: isDisabled
                  ? Colors.grey.shade500
                  : isSecondary
                      ? context.colorTheme.onSurface
                      : null, // Set the disabled text color
            ),
            onPressed: isDisabled ? null : onTap,
            child: Text(text ?? ""),
          );
  }
}
