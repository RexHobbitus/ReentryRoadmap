import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';

class CheckInOtherResource extends StatefulWidget {
  const CheckInOtherResource({super.key});

  @override
  State<CheckInOtherResource> createState() =>
      _CheckInOtherResourceState();
}

class _CheckInOtherResourceState extends State<CheckInOtherResource> {

   CheckInCubit get cubit  => getIt();

   bool isNone=false;
  String _otherResource="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNone=!cubit.isOtherResource;
    _otherResource=cubit.otherResource;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(isNone.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Are you looking for any other resources we haven’t mentioned?",
        ),
        CustomTextField(
          initialValue:_otherResource,
          isDetail: true,
          disable: isNone,
          key: UniqueKey(),
          onChange: (val){
            _otherResource=val;
            cubit.otherResource=val;
            cubit.notifyTextFieldUpdates();
          },
          bottomPadding: 10,
        ),
        CustomCheckBox(
          value:isNone,
          onChange: (va){
            setState(() {
              isNone=va;
            if(va){
                cubit.otherResource="";
                _otherResource="";
            }
            cubit.isOtherResource=!va;
            cubit.notifyTextFieldUpdates();
            });
          },
        ),
      ],
    );
  }
}
