import 'package:flutter/material.dart';
import '../../../../widgets/custom_title_card.dart';
import 'profile_view_text_field.dart';

class ProfileIncarcerationDetails extends StatelessWidget {
  const ProfileIncarcerationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTitleCard(
      title: 'Incarceration Details',
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileViewTextField(
              title: 'ID Number',
              hint: 'Federal Prison ID - ABC123',
            ),
            ProfileViewTextField(
              title: 'Number of Times Incarcerated',
              hint: '1-3',
            ),
            ProfileViewTextField(
              title: 'Incarceration History',
              hint: 'In and Out my entire life',
            ),
            ProfileViewTextField(
              title: 'Latest Offence Type',
              hint: 'Violent',
            ),
            ProfileViewTextField(
              title: 'Length of Longest Incarceration',
              hint: '0-3 years',
            ),
            ProfileViewTextField(
              title: 'Length of Latest Incarceration',
              hint: '0-3 years',
            ),
            ProfileViewTextField(
              title: 'First Incarceration Date',
              hint: 'June 13, 204',
            ),
            ProfileViewTextField(
              title: 'Latest Release Date',
              hint: 'June 13, 2024',
            ),
            ProfileViewTextField(
              title: 'Most Recent Term Served in',
              hint: 'County Jail',
            ),
            ProfileViewTextField(
              isDetail: true,
              title: 'Programs Attended While Incarcerated',
              hint:
                  'Alternatives to Violence Project (AVP), Arts in Corrections, BRAG (Brothers Reaching Across the Gate)',
            ),
          ],
        ),
      ),
    );
  }
}
