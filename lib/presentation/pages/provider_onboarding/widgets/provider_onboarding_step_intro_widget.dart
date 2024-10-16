import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class ProviderOnboardingStepIntroWidget extends StatelessWidget {
  final String? part;
  final  String title;
  final Widget subTitle;
  const ProviderOnboardingStepIntroWidget({super.key,required this.title,required this.subTitle,required this.part});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: context.sh*0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Part $part",style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.w600
          ),),
          const SizedBox(height: 10,),
          Text(title,style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600
          ),),
          const SizedBox(height: 10,),
          subTitle,

        ],
      ),
    );
  }
}
