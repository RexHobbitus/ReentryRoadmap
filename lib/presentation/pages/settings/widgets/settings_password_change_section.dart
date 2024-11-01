import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../widgets/custom_button.dart';

class SettingsPasswordChangeSection extends StatelessWidget {
  const SettingsPasswordChangeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: context.themeData.cardColor,
      backgroundColor: context.themeData.cardColor,
      tilePadding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.topLeft,
      childrenPadding: const EdgeInsets.all(kScreenHorizontalPadding),
      iconColor: context.themeData.colorScheme.secondary,
      title: Text(
        'Change Password',
        style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      children: [
        CustomTextField(
          controller: TextEditingController(),
          label: "Enter Current Password",
          suffix: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
        ),
        CustomTextField(
          controller: TextEditingController(),
          label: "Enter New Password",
          suffix: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
        ),
        CustomTextField(
          controller: TextEditingController(),
          label: "Confirm New Password",
          suffix: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: context.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
              color: context.colorScheme.secondary,
            ),
          ),
        ),
        CustomButton(
          text: "Change Password",
          onTap: () {},
          isLoading: false,
          isSecondary: true,
        ),
      ],
    );
  }
}
