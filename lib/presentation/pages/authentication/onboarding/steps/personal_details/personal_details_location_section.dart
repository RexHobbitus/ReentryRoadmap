import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../onboarding_cubit.dart';

class PersonalDetailsLocationSection extends StatelessWidget {
   PersonalDetailsLocationSection({super.key});

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
              controller: cubit.txtLocationStreet,
              label: "Street Address (optional)",
            ),
            CustomTextField(
              controller:cubit.txtLocationCity,
              label: "City",
            ),
            CustomTextField(
              controller: cubit.txtLocationState,
              label: "State",
              disable: true,
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    cubit.txtLocationState.text=country.name;
                    print('Select country: ${country.name}');
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
