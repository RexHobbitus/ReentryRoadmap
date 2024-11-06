import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';

class CurrentNeedsCareerChange extends StatefulWidget {
  const CurrentNeedsCareerChange({super.key});

  @override
  State<CurrentNeedsCareerChange> createState() => _CurrentNeedsCareerChangeState();
}

class _CurrentNeedsCareerChangeState extends State<CurrentNeedsCareerChange> {
  final List<String> options = [
    "Yes",
    "No",
  ];

  String selected = "";

  OnboardingCubit get cubit => getIt();

  @override
  void initState() {
    super.initState();
    selected = cubit.lookingForCareerChange;
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
                    cubit.lookingForCareerChange = option;
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
