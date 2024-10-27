import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInSalaryLevel extends StatefulWidget {
  const CheckInSalaryLevel({super.key});

  @override
  State<CheckInSalaryLevel> createState() =>
      _CheckInSalaryLevelState();
}

class _CheckInSalaryLevelState extends State<CheckInSalaryLevel> {
  final List<String> salaryRanges = [
    "Working for free",
    "Less than \$25,000",
    "\$25,000 - \$50,000",
    "\$50,000 - \$100,000",
    "\$100,000 +"
  ];

  String selected = "";

  CheckInCubit get cubit  => getIt();

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
        const CheckInTitleWidget(
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
