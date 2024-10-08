import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';


class CurrentNeedsEducationLevel extends StatefulWidget {
  const CurrentNeedsEducationLevel({super.key});

  @override
  State<CurrentNeedsEducationLevel> createState() => _CurrentNeedsEducationLevelState();
}

class _CurrentNeedsEducationLevelState extends State<CurrentNeedsEducationLevel> {
  final List<String> educationLevels = [
    "Working to GED",
    "High School Diploma or GED",
    "Some College",
    "Associated Degree",
    "Bachelor’s Graduate",
    "Graduate School and Beyond"
  ];

  String selected = "";
   OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selected=cubit.highestLevelOfEducation;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What is your highest level of education?",
        ),

        Wrap(
          children: [
            for (var status in educationLevels)
              CustomOptionTile(
                title: status,
                isSelected: selected == status,
                onTap: () {
                  setState(() {
                    selected = status;
                     cubit.highestLevelOfEducation=status;
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
