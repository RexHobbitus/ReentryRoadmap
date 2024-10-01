import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class PersonalDetailsGenderSection extends StatefulWidget {
  const PersonalDetailsGenderSection({super.key});

  @override
  State<PersonalDetailsGenderSection> createState() =>
      _PersonalDetailsGenderSectionState();
}

class _PersonalDetailsGenderSectionState
    extends State<PersonalDetailsGenderSection> {
  final List<String> genders = [
    "Male",
    "Female",
    "Other",
    "White",
    "Nonbinary",
  ];

  String selected = "";

  OnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Which of these best describe your gender?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            for (var gender in genders)
              CustomOptionTile(
                title: gender,
                isSelected: selected == gender,
                onTap: () {
                  setState(() {
                    selected = gender;
                    cubit.selectedGender=gender;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
