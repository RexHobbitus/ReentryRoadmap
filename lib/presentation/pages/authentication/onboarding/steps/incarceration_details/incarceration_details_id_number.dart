import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
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

  OnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIdType = cubit.idType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Please provide your ID number",
        ),
        CustomDropDown<String>(
          selectedItem: _selectedIdType.isEmpty ? null : _selectedIdType,
          items: const [
            "Federal Prison ID",
            "CDCR Number",
            "Jail ID",
            "Other Institutional ID",
          ],
          onChange: (val) {
            setState(() {
              _selectedIdType = val.toString();
              cubit.idType = val.toString();
              cubit.notifyTextFieldUpdates();
            });
          },
          label: "Select ID Type",
        ),
        _selectedIdType.toLowerCase() == "other institutional id"
            ? CustomTextField(
                width: double.infinity,
                initialValue: cubit.otherIdType,
                label: "Enter ID Type",
                onChange: (val) {
                  cubit.otherIdType = val.toString();
                  cubit.notifyTextFieldUpdates();
                },
              )
            : const SizedBox.shrink(),
        if (_selectedIdType.isNotEmpty)
          CustomTextField(
            width: double.infinity,
            initialValue: cubit.idNumber,
            label: "ID Number",
            onChange: (val) {
              cubit.idNumber = val.toString();
              cubit.notifyTextFieldUpdates();
            },
          )
        // : const SizedBox.shrink(),
      ],
    );
  }
}
