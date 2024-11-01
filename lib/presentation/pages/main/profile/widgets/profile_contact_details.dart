import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';

class ProfileContactDetailsSection extends StatelessWidget {
  const ProfileContactDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sw,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: context.themeData.cardColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _heading(context: context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  minLeadingWidth: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: SvgPicture.asset(
                    Assets.phone,
                    height: 16,
                    width: 16,
                  ),
                  title: Text(
                    '510 123 4567',
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: SvgPicture.asset(
                    Assets.email,
                    height: 14,
                    width: 14,
                  ),
                  title: Text(
                    'johndoe@gmail.com',
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: SvgPicture.asset(
                    Assets.location,
                    height: 16,
                    width: 16,
                  ),
                  title: Text(
                    '1234, La jolla Village, Hayward, California',
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading({required BuildContext context}) {
    return Container(
      width: context.sw,
      padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding, vertical: 10),
      decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Contact Details',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            label: Text(
              'Edit',
              style: context.textTheme.titleMedium!.copyWith(
                color: context.colorScheme.onSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(
              Icons.edit,
              color: context.colorScheme.onSecondary,
            ),
          )
        ],
      ),
    );
  }
}
