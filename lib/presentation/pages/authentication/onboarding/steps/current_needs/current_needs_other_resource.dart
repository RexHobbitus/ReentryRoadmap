import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';

class CurrentNeedsOtherResource extends StatefulWidget {
  const CurrentNeedsOtherResource({super.key});

  @override
  State<CurrentNeedsOtherResource> createState() =>
      _CurrentNeedsOtherResourceState();
}

class _CurrentNeedsOtherResourceState extends State<CurrentNeedsOtherResource> {

   OnboardingCubit get cubit  => getIt();

   bool isNone=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNone=!cubit.isOtherResource;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Are you looking for any other resources we haven’t mentioned?",
        ),
        CustomTextField(
          initialValue:cubit.otherResource,
          isDetail: true,
          onChange: (val){
            cubit.otherResource=val;
            cubit.notifyTextFieldUpdates();
          },
          bottomPadding: 10,
        ),
        CustomCheckBox(
          value:isNone,
          onChange: (va){
            cubit.isOtherResource=!va;
            cubit.notifyTextFieldUpdates();
          },
        ),
      ],
    );
  }
}
