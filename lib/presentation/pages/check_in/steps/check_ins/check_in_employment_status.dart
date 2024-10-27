import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../widgets/check_in_title_widget.dart';

class CheckInEmploymentStatus extends StatefulWidget {
  const CheckInEmploymentStatus({super.key});

  @override
  State<CheckInEmploymentStatus> createState() =>
      _CheckInEmploymentStatusState();
}

class _CheckInEmploymentStatusState extends State<CheckInEmploymentStatus> {
  final List<String> employmentOptions = [
    "Yes, employed full-time",
    "Yes, employed part-time",
    "No, not employed"
  ];

  String selected = "";
  CheckInCubit get cubit => getIt();
  CheckInState get state => cubit.state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = state.appUser?.onboardingInfo?.currentNeedsInfo
            ?.currentEmploymentStatus ??
        "";
    //  selected = cubit.selectedEmploymentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "Are you currently employed?",
        ),
        Wrap(
          children: [
            for (var employment in employmentOptions)
              CustomOptionTile(
                title: employment,
                isSelected: selected == employment,
                onTap: () {
                  setState(() {
                    selected = employment;
                    cubit.selectedEmploymentStatus = employment;
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
