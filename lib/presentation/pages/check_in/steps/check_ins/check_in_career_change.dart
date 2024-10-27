import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';

class CheckInCareerChange extends StatefulWidget {
  const CheckInCareerChange({super.key});

  @override
  State<CheckInCareerChange> createState() =>
      _CheckInCareerChangeState();
}

class _CheckInCareerChangeState extends State<CheckInCareerChange> {
  final List<String> options = [
    "Yes",
    "No",
  ];

  String selected = "";

   CheckInCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selected=cubit.lookingForCareerChange;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Are you looking for a career change?",
        ),

        Wrap(
          children: [
            for (var option in options)
              CustomOptionTile(
                title: option,
                isSelected: selected == option,
                onTap: () {
                  setState(() {
                    selected = option;
                    cubit.lookingForCareerChange=option;
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
