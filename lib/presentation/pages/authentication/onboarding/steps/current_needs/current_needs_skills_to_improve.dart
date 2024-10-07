import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class CurrentNeedsSkillsToImprove extends StatefulWidget {
  const CurrentNeedsSkillsToImprove({super.key});

  @override
  State<CurrentNeedsSkillsToImprove> createState() =>
      _CurrentNeedsSkillsToImproveState();
}

class _CurrentNeedsSkillsToImproveState
    extends State<CurrentNeedsSkillsToImprove> {
  final List<SkillToImprove> skillsToImprove = [
    SkillToImprove(
        title: "Digital Skills", subTitle: "Computer literacy, IT, etc"),
    SkillToImprove(
        title: "Financial Skills", subTitle: "Budgeting, managing money, etc"),
    SkillToImprove(
        title: "Technical or trade skills", subTitle: "Plumbing, Welding, etc"),
    SkillToImprove(
        title: "Professional skills",
        subTitle: "Resume writing, communication"),
    SkillToImprove(title: "Other/ None", subTitle: ""),
  ];

  List<SkillToImprove> selected = [];

  OnboardingCubit get cubit => getIt();
  bool isNone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected = cubit.selectedTypeOfOffences;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What kind of skills would you like to improve on?",
          subTitle: "Select all that apply",
        ),
        Wrap(
          children: [
            for (var skill in skillsToImprove)
              CustomOptionTile(
                title: skill.title ?? "",
                subTitle: skill.subTitle ?? "",
                isSelected: selected.contains(skill),
                onTap: () {
                  if (skill.title!.contains("Other")) {
                    setState(() {
                      selected.clear();
                      selected.add(skill);
                      return;
                    });
                  }
                  selected.remove(skillsToImprove.last);
                  setState(() {
                    if (selected.contains(skill)) {
                      selected.remove(skill);
                    } else {
                      selected.add(skill);
                    }
                  });
                  // cubit.selectedTypeOfOffences = selected;
                },
              ),
          ],
        ),
        selected.isEmpty
            ? const SizedBox.shrink()
            : selected.first.title!.contains("Other")
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What other skills would you like to improve on?",
                          style: AppStyle.onboardingTitle(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: TextEditingController(),
                          isDetail: true,
                          bottomPadding: 0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 35,
                              child: Checkbox(
                                  value: isNone,
                                  onChanged: (val) {
                                    setState(() {
                                      isNone = val ?? false;
                                    });
                                  }),
                            ),
                            const Text("None")
                          ],
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink()
      ],
    );
  }
}

class SkillToImprove extends Equatable {
  String? title;
  String? subTitle;

  SkillToImprove({this.subTitle, this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [title, subTitle];
}
