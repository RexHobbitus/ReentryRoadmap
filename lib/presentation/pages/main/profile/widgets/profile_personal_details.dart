import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_title_card.dart';

import 'profile_view_text_field.dart';

class ProfilePersonalDetails extends StatelessWidget {
  const ProfilePersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTitleCard(
      title: 'Personal Details',
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileViewTextField(
              title: 'Full Name',
              hint: 'Danathan Danamite',
            ),
            ProfileViewTextField(
              title: 'Date of Birth',
              hint: 'June 13 2024',
            ),
            ProfileViewTextField(
              title: 'Ethnicity',
              hint: 'Hispani or Latino',
            ),
            ProfileViewTextField(
              title: 'Veteran Status',
              hint: 'Not Veteran',
            ),
          ],
        ),
      ),
    );
  }
}
