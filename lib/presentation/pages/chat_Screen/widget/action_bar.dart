import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'custom_app_button.dart';

class ActionBar extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onReplyPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onMarkAsUnreadPressed;

  const ActionBar({
    Key? key,
    required this.onBackPressed,
    required this.onReplyPressed,
    required this.onDeletePressed,
    required this.onMarkAsUnreadPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Row(
        children: [
          const SizedBox(width: 5),
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 5),
          const VerticalDivider(
            endIndent: 12,
            indent: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  iconData: CupertinoIcons.reply,
                  text: 'Reply',
                  onTap: onReplyPressed,
                ),
                CustomIconButton(
                  iconData: CupertinoIcons.delete_simple,
                  text: 'Delete',
                  onTap: onDeletePressed,
                ),
                CustomIconButton(
                  iconData: Icons.mark_email_unread_outlined,
                  text: 'Mark as unread',
                  onTap: onMarkAsUnreadPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
