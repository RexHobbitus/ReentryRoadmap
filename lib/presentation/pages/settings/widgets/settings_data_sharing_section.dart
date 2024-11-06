import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../core/utils/constants.dart';
import '../settings_cubit.dart';
import '../settings_state.dart';
import 'settings_tile.dart';

class SettingsDataSharingSection extends StatelessWidget {
  const SettingsDataSharingSection({super.key, required this.cubit});

  final SettingsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: cubit,
      builder: (context, state) {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sharing your data',
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (cubit.hasSettingsChanged)
                TextButton(
                  onPressed: () {
                    cubit.updateDataSharingSettingsAction();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce the touch target size
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Save',
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
            ],
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
            SettingsTile(
              title: 'Phone Number',
              value: state.userDataSharingSettings.phoneNumber,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(phoneNumber: value),
              ),
            ),
            SettingsTile(
              title: 'Email Address',
              value: state.userDataSharingSettings.emailAddress,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(emailAddress: value),
              ),
            ),
            SettingsTile(
              title: 'Location',
              value: state.userDataSharingSettings.location,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(location: value),
              ),
            ),
            // Section: Personal Information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kScreenHorizontalPadding / 1.5),
              child: Text(
                'Personal Information',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SettingsTile(
              title: 'Full Name',
              value: state.userDataSharingSettings.fullName,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(fullName: value),
              ),
            ),
            SettingsTile(
              title: 'Date of Birth',
              value: state.userDataSharingSettings.dateOfBirth,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(dateOfBirth: value),
              ),
            ),
            SettingsTile(
              title: 'Ethnicity',
              value: state.userDataSharingSettings.ethnicity,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(ethnicity: value),
              ),
            ),
            SettingsTile(
              title: 'Gender',
              value: state.userDataSharingSettings.gender,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(gender: value),
              ),
            ),
            SettingsTile(
              title: 'Veteran Status',
              value: state.userDataSharingSettings.veteranStatus,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(veteranStatus: value),
              ),
            ), // Section: Incarceration Details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kScreenHorizontalPadding / 1.5),
              child: Text(
                'Incarceration Details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SettingsTile(
              title: 'ID Number',
              value: state.userDataSharingSettings.idNumber,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(idNumber: value),
              ),
            ),
            SettingsTile(
              title: 'Number of Times Incarcerated',
              value: state.userDataSharingSettings.timesIncarcerated,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(timesIncarcerated: value),
              ),
            ),
            SettingsTile(
              title: 'Incarceration History',
              value: state.userDataSharingSettings.incarcerationHistory,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(incarcerationHistory: value),
              ),
            ),
            SettingsTile(
              title: 'Latest Offense',
              value: state.userDataSharingSettings.latestOffense,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(latestOffense: value),
              ),
            ),
            SettingsTile(
              title: 'Length of Longest Incarceration',
              value: state.userDataSharingSettings.lengthOfLongestIncarceration,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(lengthOfLongestIncarceration: value),
              ),
            ),
            SettingsTile(
              title: 'Length of Latest Incarceration',
              value: state.userDataSharingSettings.lengthOfLatestIncarceration,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(lengthOfLatestIncarceration: value),
              ),
            ),
            SettingsTile(
              title: 'First Incarceration Date',
              value: state.userDataSharingSettings.firstIncarcerationDate,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(firstIncarcerationDate: value),
              ),
            ),
            SettingsTile(
              title: 'Latest Release Date',
              value: state.userDataSharingSettings.latestReleaseDate,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(latestReleaseDate: value),
              ),
            ),
            SettingsTile(
              title: 'Most Recent Term Served In',
              value: state.userDataSharingSettings.mostRecentTermServedIn,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(mostRecentTermServedIn: value),
              ),
            ),
            SettingsTile(
              title: 'Programs Attended While Incarcerated',
              value: state.userDataSharingSettings.programsAttendedWhileIncarcerated,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(programsAttendedWhileIncarcerated: value),
              ),
            ),
            SettingsTile(
              title: 'Phone Number',
              value: state.userDataSharingSettings.phoneNumber,
              onChange: (value) => cubit.toogleUserDataSharingSetting(
                state.userDataSharingSettings.copyWith(phoneNumber: value),
              ),
            ),
            SharePreferenceToggle(
              shareEverything: state.shareEverything,
              onChange: (value) => cubit.toggleShareEverything(value),
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
      },
    );
  }
}

class _CustomCheckBox extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool> onChange;

  const _CustomCheckBox({
    required this.value,
    required this.text,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 35,
          child: Checkbox(
            value: value,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (val) => onChange(val ?? false),
          ),
        ),
        Text(text),
      ],
    );
  }
}

class SharePreferenceToggle extends StatelessWidget {
  final bool shareEverything;
  final ValueChanged<bool> onChange;

  const SharePreferenceToggle({
    super.key,
    required this.shareEverything,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CustomCheckBox(
          text: 'Share Everything',
          value: shareEverything,
          onChange: (value) {
            onChange(value); // If Share Everything is checked, pass true
          },
        ),
        _CustomCheckBox(
          text: 'Share Nothing',
          value: !shareEverything, // Show opposite of Share Everything
          onChange: (value) {
            onChange(!value); // If Share Nothing is checked, pass false
          },
        ),
      ],
    );
  }
}
