import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

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
     selected = cubit.tradeCertifications;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Do you have any trade certifications?",
          subTitle: "Select all that apply",
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
                   cubit.tradeCertifications = selected;
                   cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
