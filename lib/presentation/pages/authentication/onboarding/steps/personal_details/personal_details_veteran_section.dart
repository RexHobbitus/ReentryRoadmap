import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class PersonalDetailsVeteranSection extends StatefulWidget {
  const PersonalDetailsVeteranSection({super.key});

  @override
  State<PersonalDetailsVeteranSection> createState() => _PersonalDetailsVeteranSectionState();
}

class _PersonalDetailsVeteranSectionState extends State<PersonalDetailsVeteranSection> {


  final List<String> veterans = [
    "Yes",
    "No"
  ];

  String selected="";
  OnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected =cubit.selectedVeteran;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Are you a veteran?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            for (var val in veterans)
              CustomOptionTile(
                title: val,
                isSelected: selected == val,
                onTap: () {
                  setState(() {
                    selected = val;
                    cubit.selectedVeteran=val;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
