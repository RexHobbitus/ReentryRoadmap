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
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: context.themeData.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colorScheme.tertiaryContainer,width: 1)
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
