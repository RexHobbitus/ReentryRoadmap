import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class CurrentNeedsSalaryLevel extends StatefulWidget {
  const CurrentNeedsSalaryLevel({super.key});

  @override
  State<CurrentNeedsSalaryLevel> createState() =>
      _CurrentNeedsSalaryLevelState();
}

class _CurrentNeedsSalaryLevelState extends State<CurrentNeedsSalaryLevel> {
  final List<String> salaryRanges = [
    "Working for free",
    "Less than \$25,000",
    "\$25,000 - \$50,000",
    "\$50,000 - \$100,000",
    "\$100,000 +"
  ];

  String selected = "";

  OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selected=cubit.currentSalaryLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What is your current salary level",
        ),
        Wrap(
          children: [
            for (var salary in salaryRanges)
              CustomOptionTile(
                title: salary,
                isSelected: selected == salary,
                onTap: () {
                  setState(() {
                    selected = salary;
                     cubit.currentSalaryLevel=salary;
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
