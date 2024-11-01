import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class SettingsNotificationTile extends StatelessWidget {
  const SettingsNotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.themeData.cardColor,
      titleTextStyle: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      title: const Text('Push Notifications'),
      trailing: CupertinoSwitch(
        value: true,
        onChanged: (newValue) {},
        activeColor: context.themeData.colorScheme.secondary,
      ),
    );
  }
}
