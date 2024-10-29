import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderOnboardingLocationSection extends StatefulWidget {
  ProviderOnboardingLocationSection({super.key});

  @override
  State<ProviderOnboardingLocationSection> createState() =>
      _ProviderOnboardingLocationSectionState();
}

class _ProviderOnboardingLocationSectionState
    extends State<ProviderOnboardingLocationSection> {
  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Please provide your location",
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Wrap(
                spacing: 10,
                children: [
                  CustomTextField(
                    width: double.infinity,
                    initialValue: cubit.locationStreet,
                    onChange: (val) {
                      cubit.locationStreet = val;
                      _checkEnableNextForThisSection();
                    },
                    label: "Street Address (optional)",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          initialValue: cubit.locationCity,
                          onChange: (val) {
                            cubit.locationCity = val;
                            _checkEnableNextForThisSection();
                          },
                          label: "City",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomTextField(
                          initialValue: cubit.locationCountry,
                          onChange: (val) {
                            cubit.locationCountry = val;
                            _checkEnableNextForThisSection();
                          },
                          label: "Country",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropDown<String>(
                          items: kUSStates,
                          selectedItem: cubit.locationState.isEmpty
                              ? null
                              : cubit.locationState,
                          onChange: (state) {
                            cubit.locationState = state ?? "";
                            _checkEnableNextForThisSection();
                          },
                          label: "State",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomTextField(
                          height: 90,
                          initialValue: cubit.locationZipCode,
                          onChange: (val) {
                            cubit.locationZipCode = val;
                            _checkEnableNextForThisSection();
                          },
                          label: "Zip Code",
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Wrap(
                spacing: 10,
                children: [
                  CustomTextField(
                    initialValue: cubit.locationStreet,
                    onChange: (val) {
                      cubit.locationStreet = val;
                      _checkEnableNextForThisSection();
                    },
                    label: "Street Address (optional)",
                  ),
                  CustomTextField(
                    initialValue: cubit.locationCity,
                    onChange: (val) {
                      cubit.locationCity = val;
                      _checkEnableNextForThisSection();
                    },
                    label: "City",
                  ),
                  CustomTextField(
                    initialValue: cubit.locationCountry,
                    onChange: (val) {
                      cubit.locationCountry = val;
                      _checkEnableNextForThisSection();
                    },
                    label: "Country",
                  ),
                  CustomDropDown<String>(
                    items: kUSStates,
                    selectedItem: cubit.locationState.isEmpty
                        ? null
                        : cubit.locationState,
                    onChange: (state) {
                      cubit.locationState = state ?? "";
                      _checkEnableNextForThisSection();
                    },
                    label: "State",
                  ),
                  CustomTextField(
                    initialValue: cubit.locationZipCode,
                    onChange: (val) {
                      cubit.locationZipCode = val;
                      _checkEnableNextForThisSection();
                    },
                    label: "Zip Code",
                  ),
                ],
              );
            }
          },
        )
      ],
    );
  }

  void _checkEnableNextForThisSection() {
    if (cubit.locationCity.isNotEmpty &&
        cubit.locationState.isNotEmpty &&
        cubit.locationCountry.isNotEmpty &&
        cubit.locationZipCode.isNotEmpty) {
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }
}
