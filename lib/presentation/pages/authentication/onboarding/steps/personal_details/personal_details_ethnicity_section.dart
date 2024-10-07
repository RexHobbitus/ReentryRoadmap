import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class PersonalDetailsEthnicitySection extends StatefulWidget {
  const PersonalDetailsEthnicitySection({super.key});

  @override
  State<PersonalDetailsEthnicitySection> createState() =>
      _PersonalDetailsEthnicitySectionState();
}

class _PersonalDetailsEthnicitySectionState
    extends State<PersonalDetailsEthnicitySection> {
  final List<String> ethnicities = [
    "Hispanic or Latino",
    "American Indian or Alaska Native",
    "Asian",
    "White",
    "Black or African American",
    "Native Hawaiian or Other Pacific Islander",
  ];

  String selected = "";
  OnboardingCubit get cubit => getIt();


  @override
  void initState() {
    super.initState();
    selected = cubit.selectedEthnicity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title:"Which of these best describe your ethnicity?",
        ),
        Wrap(
          children: [
            for (var ethnicity in ethnicities)
              CustomOptionTile(
                title: ethnicity,
                isSelected: selected == ethnicity,
                onTap: () {
                  setState(() {
                    selected = ethnicity;
                    cubit.selectedEthnicity=ethnicity;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
