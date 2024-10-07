import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../widgets/onboarding_title_widget.dart';


class CurrentNeedsHousingStatus extends StatefulWidget {
  const CurrentNeedsHousingStatus({super.key});

  @override
  State<CurrentNeedsHousingStatus> createState() => _CurrentNeedsHousingStatusState();
}

class _CurrentNeedsHousingStatusState extends State<CurrentNeedsHousingStatus> {
  final List<String> housingStatues = [
    "Housing Insecure",
    "Transitional Housing",
    "Living with family/friends",
    "Renting or owning a home"
  ];

  final List<String> immediateHousingOptions = [
    "Yes",
    "No"
  ];


  String selected = "";
  String selectedImmediateHousing = "";

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
        const OnboardingTitleWidget(
          title: "What is your current housing status?",
        ),
        Wrap(
          children: [
            for (var status in housingStatues)
              CustomOptionTile(
                title: status,
                isSelected: selected == status,
                onTap: () {
                  setState(() {
                    selected = status;
                    // cubit.selectedIncarceratedHistory=history;
                  });
                },
              ),
          ],
        ),

        selected=="Transitional Housing"?Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you in need of immediate housing?",
                style: AppStyle.onboardingTitle(context),
              ),
              const SizedBox(
                height: 20,
              ),

              Wrap(
                children: [
                  for (var option in immediateHousingOptions)
                    CustomOptionTile(
                      title: option,
                      isSelected: selectedImmediateHousing == option,
                      onTap: () {
                        setState(() {
                          selectedImmediateHousing = option;
                          // cubit.selectedIncarceratedHistory=history;
                        });
                      },
                    ),
                ],
              )
            ],
          ),
        ):const SizedBox.shrink()
      ],
    );
  }
}
