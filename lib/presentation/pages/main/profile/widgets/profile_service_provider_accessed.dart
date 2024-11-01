import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../widgets/custom_title_card.dart';

class ProfileServiceProvidersAccessed extends StatelessWidget {
  const ProfileServiceProvidersAccessed({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTitleCard(
      title: 'Service Providers Accessed',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            minLeadingWidth: 0,
            horizontalTitleGap: 0,
            titleAlignment: ListTileTitleAlignment.bottom,
            visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 40,
              child: Image.asset(
                Assets.profilePhoto,
              ),
            ),
            title: Text(
              'OpenGate Foundation',
              style: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Accessed: June 13 2024',
              style: context.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: 0,
            horizontalTitleGap: 0,
            titleAlignment: ListTileTitleAlignment.bottom,
            visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 40,
              child: Image.asset(
                Assets.profilePhoto,
              ),
            ),
            title: Text(
              'OpenGate Foundation',
              style: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Accessed: June 13 2024',
              style: context.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
