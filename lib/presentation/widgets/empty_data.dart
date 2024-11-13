import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/media_query_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/text_widgets.dart';

import '../../core/utils/assets.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        Image.asset(Assets.noData),
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        const TextWidget(
          title: "You don’t have any reviews yet",
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        const TextWidget(
          title: "Sometimes, it takes a while to get your first reviews",
          fontSize: 14,
          color: Color(0xff396773),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
