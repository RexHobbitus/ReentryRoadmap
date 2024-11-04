import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import 'message_tab.dart';

class MessageTabSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelectTab;

  const MessageTabSelector(
      {Key? key, required this.selectedIndex, required this.onSelectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.themeData.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () => onSelectTab(0),
              child: TabItem(
                title: 'New Messages',
                isSelected: selectedIndex == 0,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: GestureDetector(
              onTap: () => onSelectTab(1),
              child: TabItem(
                title: 'All Messages',
                isSelected: selectedIndex == 1,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
