import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

class AboutProviderEligibilityCriteriaSubSection extends StatelessWidget {
  const AboutProviderEligibilityCriteriaSubSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Eligibility Criteria",
            style: AppStyle.providerDetailUnderlinedSubTitle(context)),
        const SizedBox(
          height: 15,
        ),
        _eligibleTile(context: context,title: "Women"),
        _eligibleTile(context: context,title: "Within 5 years of incarceration"),

      ],
    );
  }

  Widget _eligibleTile({required BuildContext context,required String title}) {
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
