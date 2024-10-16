import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class AboutProviderFeatureSubSection extends StatelessWidget {
  const AboutProviderFeatureSubSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Features",
            style: AppStyle.providerDetailUnderlinedSubTitle(context)),
        const SizedBox(
          height: 15,
        ),
        _featureTile(context: context,title: "Holistsic Wrap-around Service"),
        _featureTile(context: context,title: "Formerly Incarcerated Leadership"),

      ],
    );
  }

  Widget _featureTile({required BuildContext context,required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 8,
            backgroundColor: context.colorScheme.primary,
            child:  Icon(
              Icons.check,
              size: 10,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: 10,),
          Text(title,style: context.textTheme.bodyMedium,)
        ],
      ),
    );
  }
}
