import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

import 'custom_button.dart';

class HeaderAuthButtons extends StatelessWidget {
  final VoidCallback? loginAction;
  final VoidCallback? signUpAction;
  final bool isMobileView;

  const HeaderAuthButtons(
      {super.key,
      this.loginAction,
      this.signUpAction,
      this.isMobileView = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          text: "Log In",
          onTap: loginAction,
          width: 100,
          height: isMobileView ? 40 : 45,
          isSecondary: true,
        ),
        signUpAction == null
            ? const SizedBox.shrink()
            : const SizedBox(
                width: 5,
              ),
        signUpAction == null
            ? const SizedBox.shrink()
            : CustomButton(
                text: "Sign Up",
                onTap: signUpAction,
                width: 100,
                height: isMobileView ? 40 : 45,
              ),
      ],
    );
  }
}
