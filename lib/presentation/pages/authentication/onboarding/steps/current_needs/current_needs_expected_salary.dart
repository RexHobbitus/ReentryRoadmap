import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

class CurrentNeedsExpectedSalary extends StatefulWidget {
  const CurrentNeedsExpectedSalary({super.key});

  @override
  State<CurrentNeedsExpectedSalary> createState() =>
      _CurrentNeedsExpectedSalaryState();
}

class _CurrentNeedsExpectedSalaryState extends State<CurrentNeedsExpectedSalary> {
  final List<String> salaryRanges = [
    "Less than \$25,000",
    "\$25,000 - \$50,000",
    "\$50,000 - \$100,000",
    "\$100,000 +"
  ];

  String selected = "";

  // OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected=cubit.selectedIncarceratedHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your expected salary level?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
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
                    // cubit.selectedIncarceratedHistory=history;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
