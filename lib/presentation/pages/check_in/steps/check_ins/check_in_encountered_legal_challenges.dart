import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/widgets/check_in_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class CheckInEncounteredLegalChallenges extends StatefulWidget {
  const CheckInEncounteredLegalChallenges({super.key});

  @override
  State<CheckInEncounteredLegalChallenges> createState() =>
      _CheckInEncounteredLegalChallengesState();
}

class _CheckInEncounteredLegalChallengesState
    extends State<CheckInEncounteredLegalChallenges> {
  final List<String> legalChallenges = [
    'None',
    'Parole/Probation Violation',
    'Police Misconduct (including parole or probation officer)',
    'Facing new misdemeanor charges',
    'Facing new felony charges',
    'New conviction (misdemeanor)',
    'New conviction (felony)',
    'Child Support/Custody hearing',
    'Other',
  ];

  List<String> selectedChallenges = [];
  TextEditingController txtOther = TextEditingController();
  bool isNoneSelected = false;
  CheckInCubit get cubit => getIt();
  CheckInState get state => cubit.state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedChallenges = cubit.legalChallenges;
    isNoneSelected = cubit.isOtherLegalChallenge;
    if (selectedChallenges.isNotEmpty &&
        selectedChallenges.first!.contains("Other")) {
      txtOther.text = selectedChallenges.first ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "What legal challenges are you currently facing?",
          subTitle: "Select all that apply",
        ),
        Wrap(
          children: [
            for (var challenge in legalChallenges)
              CustomOptionTile(
                title: challenge,
                subTitle: "",
                isSelected: selectedChallenges.contains(challenge),
                onTap: () {
                  if (challenge == 'Other') {
                    setState(() {
                      selectedChallenges.clear();
                      selectedChallenges.add(challenge);
                      cubit.notifyTextFieldUpdates();
                    });
                  } else {
                    selectedChallenges.remove('None');
                    setState(() {
                      if (selectedChallenges.contains(challenge)) {
                        selectedChallenges.remove(challenge);
                      } else {
                        selectedChallenges.add(challenge);
                      }
                      cubit.notifyTextFieldUpdates();
                    });
                  }
                },
              ),
          ],
        ),
        selectedChallenges.contains('Other')
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please specify the other legal challenges you're facing:",
                      style: AppStyle.onboardingTitle(context),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: txtOther,
                      onChange: (val) {
                        setState(() {
                          selectedChallenges[
                              selectedChallenges.indexOf('Other')] = val;
                        });
                      },
                      isDetail: true,
                      disable: isNoneSelected,
                      bottomPadding: 0,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isNoneSelected,
                          onChanged: (val) {
                            setState(() {
                              isNoneSelected = val ?? false;
                              if (isNoneSelected) {
                                txtOther.clear();
                                selectedChallenges = ['None'];
                              }
                            });
                          },
                        ),
                        const Text("None"),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
