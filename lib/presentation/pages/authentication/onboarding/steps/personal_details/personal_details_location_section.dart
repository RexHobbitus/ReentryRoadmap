import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../onboarding_cubit.dart';

class PersonalDetailsLocationSection extends StatelessWidget {
   PersonalDetailsLocationSection({super.key});

  final txtState=TextEditingController();

   OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please provide your location",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 30,
        ),
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
    );
  }
}
