import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../core/utils/assets.dart';

class SetttingsAppbarWidget extends StatelessWidget {
  const SetttingsAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back, size: 14),
              const SizedBox(width: 8),
              Text('Back', style: context.textTheme.titleSmall),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            title: Text(
              'Settings',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            minLeadingWidth: -5,
            tileColor: Colors.white,
            leading: SvgPicture.asset(
              Assets.settings,
              height: 18,
              // ignore: deprecated_member_use
              color: context.themeData.iconTheme.color,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titleAlignment: ListTileTitleAlignment.center,
          ),
        ),
      ],
    );
  }
}
