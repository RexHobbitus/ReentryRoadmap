import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChange;

  const SettingsTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: context.themeData.cardColor,
      titleTextStyle: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      visualDensity: VisualDensity.compact,
      title: Text(title),
      trailing: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChange,
          activeColor: context.themeData.colorScheme.secondary,
        ),
      ),
    );
  }
}
