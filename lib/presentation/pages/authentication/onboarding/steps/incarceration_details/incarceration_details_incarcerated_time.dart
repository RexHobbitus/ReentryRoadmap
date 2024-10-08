import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class IncarcerationDetailsIncarceratedTime extends StatefulWidget {
  const IncarcerationDetailsIncarceratedTime({super.key});

  @override
  State<IncarcerationDetailsIncarceratedTime> createState() => _IncarcerationDetailsIncarceratedTimeState();
}

class _IncarcerationDetailsIncarceratedTimeState extends State<IncarcerationDetailsIncarceratedTime> {
  final List<String> timeRange = [
    "1-3",
    "4-6",
    "7+"
  ];

  String selected = "";
  OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected=cubit.selectedIncarceratedBefore;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "How many times have you been incarcerated?",
        ),
        Wrap(
          children: [
            for (var time in timeRange)
              CustomOptionTile(
                title: time,
                isSelected: selected == time,
                onTap: () {
                  setState(() {
                    selected = time;
                    cubit.selectedIncarceratedBefore=time;
                    cubit.notifyTextFieldUpdates();
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
