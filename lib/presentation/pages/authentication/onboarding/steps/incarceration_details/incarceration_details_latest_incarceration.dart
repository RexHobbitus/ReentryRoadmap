import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class IncarcerationDetailsLatestIncarceration extends StatefulWidget {
  const IncarcerationDetailsLatestIncarceration({super.key});

  @override
  State<IncarcerationDetailsLatestIncarceration> createState() =>
      _IncarcerationDetailsLatestIncarcerationState();
}

class _IncarcerationDetailsLatestIncarcerationState
    extends State<IncarcerationDetailsLatestIncarceration> {
  final List<String> incarcerationTime = [
    "0-3 years",
    "3-5 years",
    "5-10 years",
    "10-15 years",
    "15+ years",
  ];

  OnboardingCubit get cubit  => getIt();

  String selected = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected=cubit.selectedLatestIncarcerationLength;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What was the length of your latest incarceration?",
        ),
        Wrap(
          children: [
            for (var time in incarcerationTime)
              CustomOptionTile(
                title: time,
                isSelected: selected == time,
                onTap: () {
                  setState(() {
                    selected = time;
                  });
                  cubit.selectedLatestIncarcerationLength=time;
                  cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}