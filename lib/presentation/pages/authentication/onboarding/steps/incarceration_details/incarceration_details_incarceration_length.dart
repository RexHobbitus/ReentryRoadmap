import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class IncarcerationDetailsIncarcerationLength extends StatefulWidget {
  const IncarcerationDetailsIncarcerationLength({super.key});

  @override
  State<IncarcerationDetailsIncarcerationLength> createState() =>
      _IncarcerationDetailsIncarcerationLengthState();
}

class _IncarcerationDetailsIncarcerationLengthState
    extends State<IncarcerationDetailsIncarcerationLength> {
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
    selected=cubit.selectedLongestIncarcerationLength;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What was the length of your longest incarceration?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
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
                  cubit.selectedLongestIncarcerationLength=time;
                },
              ),
          ],
        )
      ],
    );
  }
}
