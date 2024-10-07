import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class CurrentNeedsTopPriorities extends StatefulWidget {
  const CurrentNeedsTopPriorities({super.key});

  @override
  State<CurrentNeedsTopPriorities> createState() =>
      _CurrentNeedsTopPrioritiesState();
}

class _CurrentNeedsTopPrioritiesState extends State<CurrentNeedsTopPriorities> {
  final List<String> topPriorities = [
    "Education",
    "Employment",
    "Housing",
    "Life Skills",
    "Finance",
    "Legal",
    "Transportation",
    "Community",
    "Health",
  ];

  List<String> selected = [];

  OnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected = cubit.selectedTypeOfOffences;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What are your top priorities for the next few months?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Select any 3 ",
          style: AppStyle.onboardingSubTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            for (var priority in topPriorities)
              CustomOptionTile(
                title: priority,
                isSelected: selected.contains(priority),
                onTap: () {
                  setState(() {
                    if (selected.contains(priority)) {
                      selected.remove(priority);
                    } else if (!selected.contains(priority) &&
                        selected.length < 3) {
                      selected.add(priority);
                    }
                  });
                  // cubit.selectedTypeOfOffences = selected;
                },
              ),
          ],
        )
      ],
    );
  }
}
