import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/widgets/profile_title_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../widgets/custom_title_card.dart';
import 'profile_view_text_field.dart';

class ProfileCurrentNeeds extends StatelessWidget {
  const ProfileCurrentNeeds({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTitleCard(
      title: 'Current Needs',
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileTile(
              title: 'Current Top Priorities',
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hint: 'Education',
                  ),
                  CustomTextField(
                    hint: 'Employement',
                  ),
                  CustomTextField(
                    hint: 'Housing',
                  ),
                ],
              ),
            ),
            const ProfileViewTextField(
              title: 'Preferred Service Provider Size',
              hint: 'Small (0-50)',
            ),
            const ProfileViewTextField(
              title: 'Current Housing Status',
              hint: 'Housing Insecure',
            ),
            const ProfileViewTextField(
              title: 'Highest Level of Education',
              hint: 'Working to GED',
            ),
            ProfileTile(
              title: 'Trade Certifications',
              widget: Column(
                children: [
                  CustomTextField(
                    hint: 'OSHA',
                  ),
                  CustomTextField(
                    hint: 'Forklift Operator',
                  ),
                  CustomTextField(
                    hint: 'CDL',
                  ),
                ],
              ),
            ),
            ProfileTile(
              title: 'Skills to Improve on',
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hint: 'Digital Skills',
                  ),
                  CustomTextField(
                    hint: 'Financial Skills',
                  ),
                  CustomTextField(
                    isDetail: true,
                    hint:
                        'Whatever the user entered for ‘other’ would go here. In publishing and graphic design, Lorem ipsum is a placeholder text.',
                  ),
                ],
              ),
            ),
            const ProfileViewTextField(
              title: 'Current Employment Status',
              hint: 'Yes, employed full-time',
            ),
            const ProfileViewTextField(
              title: 'Current Career Track',
              hint: 'Service',
            ),
            const ProfileViewTextField(
              title: 'Current Salary Level',
              hint: '\$25,000 - \$50,000',
            ),
            ProfileTile(
              title: 'Aspiring Career Track',
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hint: 'Administrative/Office Support',
                  ),
                  CustomTextField(
                    hint: 'Labor/ Manufacturing',
                  ),
                  CustomTextField(
                    hint: 'Housing',
                  ),
                ],
              ),
            ),
            const ProfileViewTextField(
              title: 'Aspiring Salary Level',
              hint: '\$50,000 - \$100,000',
            ),
            ProfileTile(
                title: 'Other Resources Wanted',
                widget: CustomTextField(
                  isDetail: true,
                  hint:
                      'In publishing and graphic design, Lorem Ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                )),
          ],
        ),
      ),
    );
  }
}
