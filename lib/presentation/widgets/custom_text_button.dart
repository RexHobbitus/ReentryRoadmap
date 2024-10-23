import 'package:flutter/material.dart';
import '../../../core/extensions/theme_extension.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  const CustomTextButton({
    super.key,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text!,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
