import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class IncarcerationDetailsIdNumber extends StatefulWidget {
  IncarcerationDetailsIdNumber({super.key});

  @override
  State<IncarcerationDetailsIdNumber> createState() =>
      _IncarcerationDetailsIdNumberState();
}

class _IncarcerationDetailsIdNumberState
    extends State<IncarcerationDetailsIdNumber> {
  String _selectedIdType = "";
  OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIdType=cubit.txtIdType.text;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please provide your ID number",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomDropDown<String>(
          selectedItem:_selectedIdType.isEmpty?null:_selectedIdType,
          items: const [
            "Federal Prison ID",
            "CDCR Number",
            "Jail ID",
            "Other Institutional ID",
          ],
          onChange: (val) {
            setState(() {
              _selectedIdType = val.toString();
              cubit.txtIdType.text=val.toString();
            });
          },
        ),
        _selectedIdType.toLowerCase()=="other institutional id"?
        CustomTextField(controller: cubit.txtOtherIdType,label: "Enter ID Type",):const SizedBox.shrink(),
        _selectedIdType!=""?
        CustomTextField(controller:cubit.txtIdNumber,label: "ID Number",):const SizedBox.shrink(),
      ],
    );
  }
}
