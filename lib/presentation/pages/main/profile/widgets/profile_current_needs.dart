import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/widgets/profile_title_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../domain/entities/career.dart';
import '../../../../widgets/custom_title_card.dart';
import '../profile_cubit.dart';
import '../profile_state.dart';

class ProfileCurrentNeeds extends StatelessWidget {
  const ProfileCurrentNeeds({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      builder: (context, state) {
        return CustomTitleCard(
          title: 'Current Needs',
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileTile(
                    title: 'Current Top Priorities',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cubit.selectedTopPriorities.isEmpty
                          ? [CustomTextField(width: double.maxFinite, hint: 'No priorities')]
                          : cubit.selectedTopPriorities.map((priority) {
                              return !state.edit
                                  ? CustomTextField(
                                      width: double.maxFinite,
                                      hint: priority,
                                      readOnly: true,
                                    )
                                  : CustomDropDown(
                                      selectedItem: priority,
                                      width: double.maxFinite,
                                      items: cubit.topPriorities,
                                      onChange: (String? selectedValue) {
                                        if (selectedValue == null) return;
                                        final index =
                                            cubit.selectedTopPriorities.indexWhere((item) => item == priority);
                                        if (index != -1) {
                                          cubit.selectedTopPriorities[index] = selectedValue;
                                          cubit.notifyTextFieldUpdates();
                                        }
                                      },
                                    );
                            }).toList(),
                    )),
                ProfileTile(
                  title: 'Preferred Service Provider Size',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.selectedServiceProviderSize,
                          readOnly: true,
                        )
                      : CustomDropDown(
                          selectedItem: cubit.selectedServiceProviderSize,
                          width: double.maxFinite,
                          items: cubit.serviceProviderSizes,
                          onChange: (String? selectedValue) {
                            if (selectedValue == null) return;
                            cubit.selectedServiceProviderSize = selectedValue;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
                ProfileTile(
                  title: 'Current Housing Status',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.selectedHousingStatus,
                          readOnly: true,
                        )
                      : CustomDropDown(
                          selectedItem: cubit.selectedHousingStatus,
                          width: double.maxFinite,
                          items: cubit.housingStatues,
                          onChange: (String? selectedValue) {
                            if (selectedValue == null) return;
                            cubit.selectedHousingStatus = selectedValue;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
                ProfileTile(
                  title: 'Highest Level of Education',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.highestLevelOfEducation,
                          readOnly: true,
                        )
                      : CustomDropDown(
                          selectedItem: cubit.highestLevelOfEducation,
                          width: double.maxFinite,
                          items: cubit.educationLevels,
                          onChange: (String? selectedValue) {
                            if (selectedValue == null) return;
                            cubit.highestLevelOfEducation = selectedValue;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
                ProfileTile(
                    title: 'Trade Certifications',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cubit.tradeCertifications.isEmpty
                          ? [CustomTextField(width: double.maxFinite, hint: 'No certifications')]
                          : cubit.tradeCertifications.map((item) {
                              return !state.edit
                                  ? CustomTextField(
                                      width: double.maxFinite,
                                      hint: item,
                                      readOnly: true,
                                    )
                                  : CustomDropDown(
                                      selectedItem: item,
                                      width: double.maxFinite,
                                      items: cubit.certifications,
                                      onChange: (String? selectedValue) {
                                        if (selectedValue == null) return;
                                        final index = cubit.tradeCertifications.indexWhere((v) => v == item);
                                        if (index != -1) {
                                          cubit.tradeCertifications[index] = selectedValue;
                                          cubit.notifyTextFieldUpdates();
                                        }
                                      },
                                    );
                            }).toList(),
                    )),
                ProfileTile(
                  title: 'Skills to improve on',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cubit.skillsToImprove.isEmpty
                        ? [CustomTextField(width: double.maxFinite, hint: 'No skills selected')]
                        : cubit.skillsToImprove.map((item) {
                            return !state.edit
                                ? CustomTextField(
                                    width: double.maxFinite,
                                    hint: item.title,
                                    readOnly: true,
                                  )
                                : CustomDropDown(
                                    selectedItem: item.title,
                                    width: double.maxFinite,
                                    items: cubit.skillsToImproveAll.map((skill) => skill.title ?? "").toList(),
                                    onChange: (String? selectedTitle) {
                                      if (selectedTitle == null) return;

                                      final selectedSkill = cubit.skillsToImproveAll
                                          .firstWhere((skill) => skill.title == selectedTitle, orElse: () => item);

                                      final index = cubit.skillsToImprove.indexWhere((v) => v == item);
                                      if (index != -1) {
                                        cubit.skillsToImprove[index] = selectedSkill;
                                        cubit.notifyTextFieldUpdates();
                                      }
                                    },
                                  );
                          }).toList(),
                  ),
                ),
                ProfileTile(
                  title: 'Current Employment Status',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.selectedEmploymentStatus,
                          readOnly: true,
                        )
                      : CustomDropDown(
                          selectedItem: cubit.selectedEmploymentStatus,
                          width: double.maxFinite,
                          items: cubit.employmentOptions,
                          onChange: (String? selectedValue) {
                            if (selectedValue == null) return;
                            cubit.selectedEmploymentStatus = selectedValue;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
                ProfileTile(
                  title: 'Current Career Track',
                  child: cubit.currentCareer == null
                      ? const SizedBox.shrink()
                      : !state.edit
                          ? CustomTextField(
                              width: double.maxFinite,
                              hint: cubit.currentCareer!.title,
                              readOnly: true,
                            )
                          : CustomDropDown<String?>(
                              selectedItem: cubit.currentCareer!.title,
                              width: double.maxFinite,
                              items: cubit.careers.map((v) => v.title).toList(),
                              onChange: (String? selectedValue) {
                                if (selectedValue == null) return;
                                final index = cubit.careers.indexWhere((v) => v.title == selectedValue);
                                if (index != -1) {
                                  // Update the current career based on the selected value
                                  cubit.currentCareer =
                                      cubit.careers[index]; // Assuming currentCareer is a single object
                                  cubit.notifyTextFieldUpdates();
                                }
                              },
                            ),
                ),
                ProfileTile(
                  title: 'Current Salary Level',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.currentSalaryLevel,
                          readOnly: true,
                        )
                      : CustomDropDown(
                          selectedItem: cubit.currentSalaryLevel,
                          width: double.maxFinite,
                          items: cubit.salaryRanges,
                          onChange: (String? selectedValue) {
                            if (selectedValue == null) return;
                            cubit.currentSalaryLevel = selectedValue;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
                ProfileTile(
                  title: 'Careers to pursue',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cubit.careersToPursue.isEmpty
                        ? [CustomTextField(width: double.maxFinite, hint: 'No career selected')]
                        : cubit.careersToPursue.map((item) {
                            return !state.edit
                                ? CustomTextField(
                                    width: double.maxFinite,
                                    hint: item.title,
                                    readOnly: true,
                                  )
                                : CustomDropDown(
                                    selectedItem: item.title,
                                    width: double.maxFinite,
                                    items: cubit.careers.map((career) => career.title ?? "").toList(),
                                    onChange: (String? selectedTitle) {
                                      if (selectedTitle == null) return;

                                      // Find the `Career` object that matches the selected title
                                      Career selectedCareer = cubit.careers.firstWhere(
                                        (c) => c.title == selectedTitle,
                                        orElse: () => item,
                                      );

                                      final index = cubit.careersToPursue.indexWhere((v) => v == item);
                                      if (index != -1) {
                                        cubit.careersToPursue[index] = selectedCareer;
                                        cubit.notifyTextFieldUpdates();
                                      }
                                    },
                                  );
                          }).toList(),
                  ),
                ),
                ProfileTile(
                  title: 'Aspiring Salary Level',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.expectedSalaryLevel,
                          readOnly: true,
                        )
                      : CustomDropDown(
                          selectedItem: cubit.expectedSalaryLevel,
                          width: double.maxFinite,
                          items: cubit.expectedSalaryRanges,
                          onChange: (String? selectedValue) {
                            if (selectedValue == null) return;
                            cubit.expectedSalaryLevel = selectedValue;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
                ProfileTile(
                  title: 'Other Resources Wanted',
                  child: !state.edit
                      ? CustomTextField(
                          width: double.maxFinite,
                          hint: cubit.otherResource,
                          readOnly: true,
                        )
                      : CustomTextField(
                          width: double.maxFinite,
                          initialValue: cubit.otherResource,
                          keyboard: TextInputType.text,
                          isDetail: true,
                          maxLength: 5,
                          onChange: (val) {
                            cubit.otherResource = val;
                            cubit.notifyTextFieldUpdates();
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
