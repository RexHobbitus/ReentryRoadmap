import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class SettingsTile extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool)? onChange;

  const SettingsTile({
    super.key,
    required this.title,
    this.value = false,
    this.onChange,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: null,
      dense: true,
      tileColor: context.themeData.cardColor,
      titleTextStyle: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      visualDensity: VisualDensity.compact,
      title: Text(widget.title),
      trailing: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          value: true,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
            widget.onChange?.call(value);
          },
          activeColor: context.themeData.colorScheme.secondary,
        ),
      ),
    );
  }
}
