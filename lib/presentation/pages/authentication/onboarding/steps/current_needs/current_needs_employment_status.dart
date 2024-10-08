import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../widgets/onboarding_title_widget.dart';


class CurrentNeedsEmploymentStatus extends StatefulWidget {
  const CurrentNeedsEmploymentStatus({super.key});

  @override
  State<CurrentNeedsEmploymentStatus> createState() => _CurrentNeedsEmploymentStatusState();
}

class _CurrentNeedsEmploymentStatusState extends State<CurrentNeedsEmploymentStatus> {
  final List<String> employmentOptions = [
    "Yes, employed full-time",
    "Yes, employed part-time",
    "No, not employed"
  ];

  String selected = "";
   OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selected=cubit.selectedEmploymentStatus;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Are you currently employed?",
        ),
        Wrap(
          children: [
            for (var employment in employmentOptions)
              CustomOptionTile(
                title: employment,
                isSelected: selected == employment,
                onTap: () {
                  setState(() {
                    selected = employment;
                    cubit.selectedEmploymentStatus=employment;
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
