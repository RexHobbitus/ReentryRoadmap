import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../onboarding_cubit.dart';

class PersonalDetailsLocationSection extends StatefulWidget {
  PersonalDetailsLocationSection({super.key});

  @override
  State<PersonalDetailsLocationSection> createState() =>
      _PersonalDetailsLocationSectionState();
}

class _PersonalDetailsLocationSectionState
    extends State<PersonalDetailsLocationSection> {
  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Please provide your location",
        ),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxWidth < 600
              ? Wrap(
                  spacing: 10,
                  children: [
                    CustomTextField(
                      initialValue: cubit.locationStreet,
                      onChange: (val) {
                        cubit.locationStreet = val;
                        cubit.notifyTextFieldUpdates();
                      },
                      label: "Street Address (optional)",
                    ),
                    CustomTextField(
                      initialValue: cubit.locationCity,
                      onChange: (val) {
                        cubit.locationCity = val;
                        cubit.notifyTextFieldUpdates();
                      },
                      label: "City",
                    ),
                    CustomDropDown<String>(
                      items: kUSStates,
                      selectedItem: cubit.locationState.isEmpty
                          ? "California"
                          : cubit.locationState,
                      onChange: (state) {
                        cubit.locationState = state ?? "";
                        cubit.notifyTextFieldUpdates();
                      },
                      label: "State",
                    ),
                  ],
                )
              : Wrap(
                  spacing: 10,
                  children: [
                    CustomTextField(
                      width: double.infinity,
                      initialValue: cubit.locationStreet,
                      onChange: (val) {
                        cubit.locationStreet = val;
                        cubit.notifyTextFieldUpdates();
                      },
                      label: "Street Address (optional)",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: TextFormField(
                              style: AppStyle.textFieldTextStyle(context),
                              initialValue: cubit.locationCity,
                              onChanged: (val) {
                                cubit.locationCity = val;
                                cubit.notifyTextFieldUpdates();
                              },
                              decoration: InputDecoration(
                                label: Text("City"),
                                labelStyle: AppStyle.hintStyle(context),
                                hoverColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 22),
                                fillColor: context.colorScheme.surfaceDim,
                                enabledBorder: borderStyle(context),
                                focusedBorder:
                                    borderStyle(context, isActive: true),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Optional spacing between the two widgets
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: CustomDropDown<String>(
                              items: kUSStates,
                              selectedItem: cubit.locationState.isEmpty
                                  ? "California"
                                  : cubit.locationState,
                              onChange: (state) {
                                cubit.locationState = state ?? "";
                                cubit.notifyTextFieldUpdates();
                              },
                              label: "State",
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
        })
      ],
    );
  }

  borderStyle(BuildContext context, {bool isActive = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: context.colorScheme.tertiaryContainer,
        width: 1.5,
      ),
    );
  }
}
