import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class ExploreHeaderAuthButtons extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;

  const ExploreHeaderAuthButtons({super.key,this.onLogin,this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CustomButton(
          text: "Log In",
          onTap: onLogin,
          width:100,
          height:35,
          isSecondary: true,
        ),
        const SizedBox(width: 5,),
        CustomButton(
          text: "Sign Up",
          onTap: onSignUp,
          width:100,
          height:35,
        ),
        const SizedBox(width: kScreenHorizontalPadding,),
      ],
    );
  }
}
