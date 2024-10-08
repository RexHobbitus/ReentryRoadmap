import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../onboarding_cubit.dart';

class PersonalDetailsLocationSection extends StatefulWidget {
   PersonalDetailsLocationSection({super.key});

  @override
  State<PersonalDetailsLocationSection> createState() => _PersonalDetailsLocationSectionState();
}

class _PersonalDetailsLocationSectionState extends State<PersonalDetailsLocationSection> {
   OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Please provide your location",
        ),
        Wrap(
          spacing: 10,
          children: [
            CustomTextField(
              initialValue: cubit.locationStreet,
              onChange: (val){
                cubit.locationStreet=val;
                cubit.notifyTextFieldUpdates();
              },
              label: "Street Address (optional)",
            ),
            CustomTextField(
              initialValue: cubit.locationCity,
              onChange: (val){
                cubit.locationCity=val;
                cubit.notifyTextFieldUpdates();
              },
              label: "City",
            ),
            CustomTextField(
              initialValue: cubit.locationState,
              label: "State",
              disable: true,
              key: UniqueKey(),
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    setState(() {
                      cubit.locationState=country.name;
                      cubit.notifyTextFieldUpdates();
                    });

                  },
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
