import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderDescribeLocationWidget extends StatefulWidget {
  const ProviderDescribeLocationWidget({super.key});

  @override
  State<ProviderDescribeLocationWidget> createState() => _ProviderDescribeLocationWidgetState();
}

class _ProviderDescribeLocationWidgetState extends State<ProviderDescribeLocationWidget> {
  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "Describe your provider location in a few sentences",
          subTitle:
              'What is your story? Why are you here? Just a few sentences to help clients know you better',
        ),
        Wrap(
          spacing: 15,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return CustomTextField(
                  width: double.infinity,
                  isMaxlength: true,
                  isDetail: true,
                  maxLength: 500,
                  initialValue: cubit.describeProviderLocation,
                  onChange: (val) {
                    cubit.describeProviderLocation = val;
                    _checkEnableNextForThisSection();
                  },
                  label: "Describe Provider Location",
                );
              } else {
                return CustomTextField(
                  isMaxlength: true,
                  isDetail: true,
                  maxLength: 500,
                  initialValue: cubit.describeProviderLocation,
                  onChange: (val) {
                    cubit.describeProviderLocation = val;
                    _checkEnableNextForThisSection();
                  },
                  label: "Describe Provider Location",
                );
              }
            })
          ],
        )
      ],
    );
  }

  void _checkEnableNextForThisSection() {
    if (cubit.describeProviderLocation.isNotEmpty) {
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }
}
