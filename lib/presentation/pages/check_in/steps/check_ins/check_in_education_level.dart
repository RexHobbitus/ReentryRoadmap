import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInEducationLevel extends StatefulWidget {
  const CheckInEducationLevel({super.key});

  @override
  State<CheckInEducationLevel> createState() => _CheckInEducationLevelState();
}

class _CheckInEducationLevelState extends State<CheckInEducationLevel> {
  final List<String> educationLevels = [
    "Working to GED",
    "High School Diploma or GED",
    "Some College",
    "Associated Degree",
    "Bachelor’s Graduate",
    "Graduate School and Beyond"
  ];

  String selected = "";
  CheckInCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.highestLevelOfEducation;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
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
                    cubit.highestLevelOfEducation = status;
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
