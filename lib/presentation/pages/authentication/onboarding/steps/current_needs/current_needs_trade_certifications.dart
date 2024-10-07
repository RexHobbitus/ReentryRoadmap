import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class CurrentNeedsTradeCertifications extends StatefulWidget {
  const CurrentNeedsTradeCertifications({super.key});

  @override
  State<CurrentNeedsTradeCertifications> createState() =>
      _CurrentNeedsTradeCertificationsState();
}

class _CurrentNeedsTradeCertificationsState
    extends State<CurrentNeedsTradeCertifications> {
  final List<String> certifications = [
    "None",
    "OSHA",
    "CDL",
    "HVAC",
    "Building Maintenance",
    "Plumbing",
    "ServSafe",
    "CNA",
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
          "Do you have any trade certifications?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Select all that apply",
          style: AppStyle.onboardingSubTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            for (var certificate in certifications)
              CustomOptionTile(
                title: certificate,
                isSelected: selected.contains(certificate),
                onTap: () {
                  setState(() {
                    if (selected.contains(certificate)) {
                      selected.remove(certificate);
                    } else {
                      selected.add(certificate);
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
