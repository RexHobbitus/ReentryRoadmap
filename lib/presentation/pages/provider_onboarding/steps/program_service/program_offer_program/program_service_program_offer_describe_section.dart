import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceProgramOfferDescribeSection extends StatefulWidget {
  final int index;
  const ProgramServiceProgramOfferDescribeSection({
    super.key,
    required this.index,
  });

  @override
  State<ProgramServiceProgramOfferDescribeSection> createState() => _ProgramServiceProgramOfferDescribeSectionState();
}

class _ProgramServiceProgramOfferDescribeSectionState extends State<ProgramServiceProgramOfferDescribeSection> {
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
          title: "Describe the program in a few sentences",
        ),
        kIsWeb?
        Wrap(
          spacing: 15,
          children: [
            CustomTextField(
              width: double.infinity,
              isDetail: true,
              initialValue: cubit.selectedPrograms[widget.index].description,
              onChange: (val) {
                cubit.selectedPrograms[widget.index].description = val;
                _checkEnableNextForThisSection();
              },
            ),
          ],
        ):
         Wrap(
          spacing: 15,
          children: [
            CustomTextField(
              isDetail: true,
              initialValue: cubit.selectedPrograms[widget.index].description,
              onChange: (val) {
                cubit.selectedPrograms[widget.index].description = val;
                _checkEnableNextForThisSection();
              },
            ),
          ],
        )
      ],
    );
  }

  void _checkEnableNextForThisSection() {
    if( cubit.selectedPrograms[widget.index].description?.isNotEmpty??false){
      cubit.isNextButtonEnabled.value = true;
      return ;
    }
    cubit.isNextButtonEnabled.value = false;
  }
}
