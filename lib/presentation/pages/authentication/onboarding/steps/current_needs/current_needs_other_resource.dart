import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class CurrentNeedsOtherResource extends StatefulWidget {
  const CurrentNeedsOtherResource({super.key});

  @override
  State<CurrentNeedsOtherResource> createState() =>
      _CurrentNeedsOtherResourceState();
}

class _CurrentNeedsOtherResourceState extends State<CurrentNeedsOtherResource> {
  String selected = "";

  // OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected=cubit.selectedIncarceratedHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Are you looking for any other resources we haven’t mentioned?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: TextEditingController(),
          isDetail: true,
          bottomPadding: 0,
        ),
        CustomCheckBox(),
      ],
    );
  }
}
