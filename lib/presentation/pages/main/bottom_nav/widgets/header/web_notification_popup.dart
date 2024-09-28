import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/notification_tile.dart';

class WebNotificationPopup extends StatelessWidget {
  const WebNotificationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 600,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeData.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Notifications",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(vertical: 20),
            child:  Divider(
              thickness: 2,
              height: 0,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const NotificationTile();
                }),
          )
        ],
      ),
    );
  }
}
