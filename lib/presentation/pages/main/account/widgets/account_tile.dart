import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onTap,
  });

  final String text, iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        title: Text(
          text,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        minLeadingWidth: -5,
        tileColor: context.themeData.cardColor,
        leading: SvgPicture.asset(
          iconPath,
          height: 18,
          // ignore: deprecated_member_use
          color: context.themeData.iconTheme.color,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: onTap,
        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }
}
