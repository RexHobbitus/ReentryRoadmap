import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SvgPicture.asset(Assets.notificationBullet),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "There’s been an update on your OpenGate Oakland Application!",
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 5,),
                Text(
                  "13 Sept 2024  •  2 days ago",
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: context.colorScheme.tertiary),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                        text: "View Update in ",
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.tertiary),
                        children: [
                      TextSpan(
                        text: "My Providers",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ])),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    thickness: 2,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
