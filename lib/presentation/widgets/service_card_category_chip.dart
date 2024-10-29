import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class ServiceCardCategoryChip extends StatelessWidget {
  final String title;
  const ServiceCardCategoryChip({super.key,required this.title,});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 13),
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.themeData.colorScheme.tertiaryContainer,
          ),
          child: Center(child: Text(title,style: context.textTheme.bodySmall?.copyWith(
            color: context.themeData.colorScheme.onTertiaryContainer,
          ),),),
        ),
      ],
    );
  }
}
