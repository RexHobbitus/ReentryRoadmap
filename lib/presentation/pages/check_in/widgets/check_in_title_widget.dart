import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import '../../../../../core/utils/app_style.dart';

class CheckInTitleWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const CheckInTitleWidget({super.key,required this.title,this.subTitle=""});

  @override
  Widget build(BuildContext context) {
    return  CustomResponsiveBuilder(
      builder: (context,constraints,device) {
        return Padding(
          padding:  EdgeInsets.only(bottom: device==DeviceSize.mobile?20:30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyle.onboardingTitle(context),
              ),
              subTitle.isEmpty?const SizedBox.shrink():Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  subTitle,
                  style: AppStyle.onboardingSubTitle(context),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
