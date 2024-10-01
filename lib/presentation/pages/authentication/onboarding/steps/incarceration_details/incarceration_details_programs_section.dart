import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class IncarcerationDetailsProgramsSection extends StatefulWidget {
  const IncarcerationDetailsProgramsSection({super.key});

  @override
  State<IncarcerationDetailsProgramsSection> createState() =>
      _IncarcerationDetailsProgramsSectionState();
}

class _IncarcerationDetailsProgramsSectionState
    extends State<IncarcerationDetailsProgramsSection> {
  final List<String> programs = [
    "Alternatives to Violence Project (AVP)",
    "Arts in Corrections",
    "BRAG (Brothers Reaching Across the Gate)",
    "Criminals and Gang Members Anonymous",
    "Youth Offender Program (YOP)",
    "Parenting and Family Reunification Programs",
    "Getting Out by Going In (GOGI)",
    "Toastmasters Gavel Club",
    "Restorative Justice Program",
  ];

  OnboardingCubit get cubit  => getIt();

  List<String> selected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected=cubit.selectedPrograms;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What programs did you attend while incarcerated?",
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
            for (var program in programs)
              CustomOptionTile(
                title: program,
                isSelected: selected.contains(program),
                onTap: () {
                  setState(() {
                    if (selected.contains(program)) {
                      selected.remove(program);
                    } else {
                      selected.add(program);
                    }
                  });
                  cubit.selectedPrograms=selected;
                },
              ),
          ],
        )
      ],
    );
  }
}
