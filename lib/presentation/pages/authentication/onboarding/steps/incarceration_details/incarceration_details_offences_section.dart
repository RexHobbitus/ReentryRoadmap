import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class IncarcerationDetailsOffencesSection extends StatefulWidget {
  const IncarcerationDetailsOffencesSection({super.key});

  @override
  State<IncarcerationDetailsOffencesSection> createState() =>
      _IncarcerationDetailsOffencesSectionState();
}

class _IncarcerationDetailsOffencesSectionState
    extends State<IncarcerationDetailsOffencesSection> {
  final List<String> offences = [
    "Violent",
    "Non-violent",
    "Misdemeanor",
    "Sexual",
  ];

  List<String> selected = [];
  OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected=cubit.selectedTypeOfOffences;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What type of offence were you incarcerated for?",
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
            for (var offence in offences)
              CustomOptionTile(
                title: offence,
                isSelected: selected.contains(offence),
                onTap: () {
                  setState(() {
                    if (selected.contains(offence)) {
                      selected.remove(offence);
                    } else {
                      selected.add(offence);
                    }
                  });
                  cubit.selectedTypeOfOffences=selected;
                },
              ),
          ],
        )
      ],
    );
  }
}
