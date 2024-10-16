import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

class AboutProviderCategoriesSubSection extends StatelessWidget {
   AboutProviderCategoriesSubSection({super.key});

  final List<String> _categories=["Education","Employment","Housing"];
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Categories",style: AppStyle.providerDetailUnderlinedSubTitle(context)),
        const SizedBox(height: 15,),
        for(var index=0;index<_categories.length;index++)
        _categoryTile(context: context, title: _categories[index]),
      ],
    );
  }

  Widget _categoryTile({required BuildContext context,required String title}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: context.textTheme.bodyMedium,),
        const SizedBox(height: 8,),
        Divider(thickness: 0.5,color: context.colorScheme.onSurface,height: 0,),
        const SizedBox(height: 8,),
      ],
    );
  }
}
