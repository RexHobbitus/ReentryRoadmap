import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_check_box.dart';
import 'settings_tile.dart';

class SettingsDataSharingSection extends StatelessWidget {
  const SettingsDataSharingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: context.themeData.cardColor,
      backgroundColor: context.themeData.cardColor,
      tilePadding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      expandedAlignment: Alignment.topLeft,
      iconColor: context.themeData.colorScheme.secondary,
      title: Text(
        'Sharing your data',
        style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      children: [
        Text(
          'Select the data you’d like to share with your service providers. Sharing your data will help providers assess your eligibility for their programs and services and decrease their response time.',
          maxLines: 10,
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12, color: context.colorScheme.secondary),
        ),
        // Section: Contact Information
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kScreenHorizontalPadding / 1.5),
          child: Text(
            'Contact Information',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SettingsTile(title: 'Phone Number'),
        const SettingsTile(title: 'Email Address'),
        const SettingsTile(title: 'Location'),
        // Section: Personal Information
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kScreenHorizontalPadding / 1.5),
          child: Text(
            'Personal Information',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SettingsTile(title: 'Full Name'),
        const SettingsTile(title: 'Date of Birth'),
        const SettingsTile(title: 'Ethnicity'),
        const SettingsTile(title: 'Gender'),
        const SettingsTile(title: 'Veteran Status'),
        // Section: Incarceration Details
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kScreenHorizontalPadding / 1.5),
          child: Text(
            'Incarceration Details',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SettingsTile(title: 'ID Number'),
        const SettingsTile(title: 'Number of Times Incarcerated'),
        const SettingsTile(title: 'Incarceration History'),
        const SettingsTile(title: 'Latest Offense'),
        const SettingsTile(title: 'Length of Longest Incarceration'),
        const SettingsTile(title: 'Length of Latest Incarceration'),
        const SettingsTile(title: 'First Incarceration Date'),
        const SettingsTile(title: 'Latest Release Date'),
        const SettingsTile(title: 'Most Recent Term Served In'),
        const SettingsTile(title: 'Programs Attended While Incarcerated'),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCheckBox(
              text: 'Share Everything',
            ),
            CustomCheckBox(
              text: 'Share Nothing',
            ),
            SizedBox(
              width: 2,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.colorScheme.secondary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                'Personal Information',
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'We take the utmost care in handling your private data. You have the option to remain anonymous if you choose, and all data collected will only be used to improve our system and services. Your privacy and security are our top priorities, and we are committed to protecting your information at every step',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        )
      ],
    );
  }
}