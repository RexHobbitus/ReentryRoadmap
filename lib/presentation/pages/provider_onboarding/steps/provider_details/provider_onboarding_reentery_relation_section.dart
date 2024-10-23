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
  final List<String> relations = [
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
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Wrap(
              direction: Axis.vertical,
              children: [
                for (var relation in relations)
                  SizedBox(
                    child: CustomOptionTile(
                      title: relation,
                      isSelected: selected == relation,
                      onTap: () {
                        setState(() {
                          selected = relation;
                          cubit.relationReentry = relation;
                          print(cubit.relationReentry);
                        });
                        cubit.notifyTextFieldUpdates();
                      },
                    ),
                  ),
              ],
            );
          } else {
            return Wrap(
              children: [
                for (var relation in relations)
                  CustomOptionTile(
                    title: relation,
                    isSelected: selected == relation,
                    onTap: () {
                      setState(() {
                        selected = relation;
                        cubit.relationReentry = relation;
                        print(cubit.relationReentry);
                      });
                      cubit.notifyTextFieldUpdates();
                    },
                  ),
              ],
            );
          }
        })
      ],
    );
  }
}
