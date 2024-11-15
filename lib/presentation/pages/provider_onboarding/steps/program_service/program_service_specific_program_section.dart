import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceSpecificProgramSection extends StatefulWidget {
  const ProgramServiceSpecificProgramSection({super.key});

  @override
  State<ProgramServiceSpecificProgramSection> createState() =>
      _ProgramServiceSpecificProgramSectionState();
}

class _ProgramServiceSpecificProgramSectionState
    extends State<ProgramServiceSpecificProgramSection> {
  final List<String> specificProgram = ["Yes", "No"];

  String selected = "";
  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.specificProgram;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Do you have any specific programs?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        kIsWeb
            ? Wrap(
                direction: Axis.vertical,
                children: [
                  for (var val in specificProgram)
                    CustomOptionTile(
                      title: val,
                      isSelected: selected == val,
                      onTap: () {
                        setState(() {
                          selected = val;
                          cubit.specificProgram = val;
                        });
                        _checkEnableNextForThisSection();
                      },
                    ),
                ],
              )
            : Wrap(
                children: [
                  for (var val in specificProgram)
                    CustomOptionTile(
                      title: val,
                      isSelected: selected == val,
                      onTap: () {
                        setState(() {
                          selected = val;
                          cubit.specificProgram = val;
                        });
                        _checkEnableNextForThisSection();
                      },
                    ),
                ],
              )
      ],
    );
  }

  void _checkEnableNextForThisSection() {
    if (selected.isNotEmpty) {
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }

}
