import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInTopPriorities extends StatefulWidget {
  const CheckInTopPriorities({super.key});

  @override
  State<CheckInTopPriorities> createState() =>
      _CheckInTopPrioritiesState();
}

class _CheckInTopPrioritiesState extends State<CheckInTopPriorities> {
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

  CheckInCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.selectedTopPriorities;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "What are your top priorities for the next few months?",
          subTitle: "Select any 3",
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
                    cubit.selectedTopPriorities=selected;
                    cubit.notifyTextFieldUpdates();
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
