import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInSkillsToImprove extends StatefulWidget {
  const CheckInSkillsToImprove({super.key});

  @override
  State<CheckInSkillsToImprove> createState() =>
      _CheckInSkillsToImproveState();
}

class _CheckInSkillsToImproveState
    extends State<CheckInSkillsToImprove> {
  final List<SkillToImprove> skillsToImprove = [
    SkillToImprove(
      title: "Digital Skills",
      subTitle: "Computer literacy, IT, etc",
      value: "Digital Skills",
    ),
    SkillToImprove(
        title: "Financial Skills",
        subTitle: "Budgeting, managing money, etc",
        value: "Financial Skills"),
    SkillToImprove(
        title: "Technical or trade skills",
        subTitle: "Plumbing, Welding, etc",
        value: "Technical or trade skills"),
    SkillToImprove(
      title: "Professional skills",
      subTitle: "Resume writing, communication",
      value: "Professional skills",
    ),
    SkillToImprove(
      title: "Other/ None",
      subTitle: "",
      value: "",
    ),
  ];

  List<SkillToImprove> selected = [];

  CheckInCubit get cubit => getIt();
  bool isNone = false;

  TextEditingController txtOther = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.skillsToImprove;
    isNone = cubit.isNoSkillToImprove;
    if(selected.isNotEmpty && selected.first.title!.contains("Other")){
      txtOther.text=selected.first.value??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "What kind of skills would you like to improve on?",
          subTitle: "Select all that apply",
        ),
        Wrap(
          children: [
            for (var skill in skillsToImprove)
              CustomOptionTile(
                title:skill.title ?? "",
                subTitle: skill.subTitle ?? "",
                isSelected: selected.contains(skill),
                onTap: () {
                  if (skill.title!.contains("Other")) {
                    setState(() {
                      selected.clear();
                      selected.add(skill);
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
                  cubit.skillsToImprove = selected;
                  cubit.notifyTextFieldUpdates();
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
                          controller: txtOther,
                          onChange: (val) {
                            selected.first.value = val;
                            cubit.notifyTextFieldUpdates();
                          },
                          isDetail: true,
                          disable: isNone,
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
                                      if (isNone) {
                                        txtOther.text = "";
                                        selected.first.value = "";
                                      }
                                      cubit.isNoSkillToImprove = isNone;
                                      cubit.notifyTextFieldUpdates();
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
  String? value;
  String? subTitle;

  SkillToImprove({this.subTitle, this.title, this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [title, subTitle];
}
