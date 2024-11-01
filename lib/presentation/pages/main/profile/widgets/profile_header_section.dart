import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../../core/utils/assets.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      horizontalTitleGap: 0,
      titleAlignment: ListTileTitleAlignment.bottom,
      visualDensity: const VisualDensity(vertical: -3),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 40,
        child: Image.asset(
          Assets.profilePhoto,
        ),
      ),
      title: Text(
        'Danathan Danamite',
        style: context.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Row(
        children: [
          SvgPicture.asset(
            Assets.verified,
            height: 14,
            width: 14,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Verified User',
            style: context.textTheme.bodySmall!.copyWith(
              color: context.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
