import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInHousingStatus extends StatefulWidget {
  const CheckInHousingStatus({super.key});

  @override
  State<CheckInHousingStatus> createState() => _CheckInHousingStatusState();
}

class _CheckInHousingStatusState extends State<CheckInHousingStatus> {
  final List<String> housingStatues = [
    "Housing Insecure",
    "Transitional Housing",
    "Living with family/friends",
    "Renting or owning a home"
  ];

  final List<String> immediateHousingOptions = ["Yes", "No"];

  String selected = "";
  String selectedImmediateHousing = "";

  CheckInCubit get cubit => getIt();
  CheckInState get state => cubit.state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected =
        state.appUser.onboardingInfo?.currentNeedsInfo?.currentHousingStatus ??
            "";
    selectedImmediateHousing = state
            .appUser.onboardingInfo?.currentNeedsInfo?.needOfImmediateHousing ??
        "";

    //selected=cubit.selectedHousingStatus;
    //selectedImmediateHousing = cubit.needOfImmediateHousing;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
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
                    cubit.selectedHousingStatus = status;
                    cubit.notifyTextFieldUpdates();
                  });
                },
              ),
          ],
        ),
        selected == "Transitional Housing"
            ? Padding(
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
                                cubit.needOfImmediateHousing = option;
                                cubit.notifyTextFieldUpdates();
                              });
                            },
                          ),
                      ],
                    )
                  ],
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
