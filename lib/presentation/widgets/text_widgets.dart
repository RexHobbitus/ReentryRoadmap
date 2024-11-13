import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration decoration;
  final double fontSize;
  final int? maxLines;

  const TextWidget({
    Key? key,
    required this.title,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.decoration = TextDecoration.none,
    this.fontSize = 14.0,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontSize: fontSize,
      ),
    );
  }
}
