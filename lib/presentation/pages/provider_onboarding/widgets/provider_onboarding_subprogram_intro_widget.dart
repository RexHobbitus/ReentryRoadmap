import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class ProviderOnboardingSubprogramIntroWidget extends StatelessWidget {
  final String title;
  final Widget subTitle;
  const ProviderOnboardingSubprogramIntroWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.sh * 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          subTitle,
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
