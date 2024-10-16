import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderOnboardingReenteryRelationSection extends StatefulWidget {
  const ProviderOnboardingReenteryRelationSection({super.key});

  @override
  State<ProviderOnboardingReenteryRelationSection> createState() =>
      _ProviderOnboardingReenteryRelationSectionState();
}

class _ProviderOnboardingReenteryRelationSectionState
    extends State<ProviderOnboardingReenteryRelationSection> {
  final List<String> veterans = [
    "Focused solely on reentry",
    "Reentry adjacent"
  ];

  String selected = "";
  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.relationReentry;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your relation to reentry?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            for (var val in veterans)
              CustomOptionTile(
                title: val,
                isSelected: selected == val,
                onTap: () {
                  setState(() {
                    selected = val;
                    cubit.relationReentry = val;
                  });
                  cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
