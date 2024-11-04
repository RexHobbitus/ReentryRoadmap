import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class ServiceCardCategoryChip extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? textColor;

  const ServiceCardCategoryChip({super.key,required this.title, this.bgColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 13),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: bgColor ?? context.themeData.colorScheme.tertiaryContainer,
          ),
          child: Center(child: Text(title,style: context.textTheme.bodySmall?.copyWith(
            color: textColor ?? context.themeData.colorScheme.onTertiaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 10
          ),),),
        ),
      ],
    );
  }
}
