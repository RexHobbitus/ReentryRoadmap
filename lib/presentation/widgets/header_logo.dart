import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

import '../../core/utils/assets.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Assets.dignifi),
          const SizedBox(
            width: 20,
          ),
          Text(
            "Dignifi",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
}
