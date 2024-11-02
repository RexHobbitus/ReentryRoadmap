import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../widgets/custom_button.dart';
import '../settings_cubit.dart';
import '../settings_state.dart';

class SettingsPasswordChangeSection extends StatelessWidget {
  const SettingsPasswordChangeSection({super.key, required this.cubit});

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
          expandedAlignment: Alignment.topLeft,
          childrenPadding: const EdgeInsets.all(kScreenHorizontalPadding),
          iconColor: context.themeData.colorScheme.secondary,
          title: Text(
            'Change Password',
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          children: [
            CustomTextField(
              controller: cubit.txtCurrentPassword,
              label: "Enter Current Password",
              suffix: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
              width: double.maxFinite,
            ),
            CustomTextField(
              controller: cubit.txtNewPassword,
              label: "Enter New Password",
              suffix: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
              width: double.maxFinite,
            ),
            CustomTextField(
              controller: cubit.txtConfirmNewPassword,
              label: "Confirm New Password",
              suffix: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
              width: double.maxFinite,
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
            const SizedBox(
              height: 8,
            ),
            CustomButton(
              text: "Change Password",
              onTap: cubit.changePasswordAction,
              isLoading: state.loading,
              isSecondary: true,
            ),
          ],
        );
      },
    );
  }
}
