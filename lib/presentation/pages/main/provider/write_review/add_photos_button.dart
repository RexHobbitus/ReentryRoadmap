import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class AddPhotosButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AddPhotosButton({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        width: context.sw,
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: context.themeData.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colorScheme.tertiary,width: 1)
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add,size: 15,),
              Text(" Add Photos",style: context.textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
