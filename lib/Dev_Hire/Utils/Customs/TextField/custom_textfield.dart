import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final int maxlines;
  final bool hasLable;
  final String lableText;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.validator,
    this.obscureText = false, this.maxlines = 1, this.hasLable = false, this.lableText = 'Label Text',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: hasLable? Text(lableText): null,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF1F6F8)), // Color when enabled
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff396773)), // Color when focused
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Color when there's an error
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Color when focused with an error
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator, // Add validator to the TextFormField
    );
  }
}
