import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';
class IncarcerationDetailsRecentServe extends StatefulWidget {
  const IncarcerationDetailsRecentServe({super.key});

  @override
  State<IncarcerationDetailsRecentServe> createState() => _IncarcerationDetailsRecentServeState();
}

class _IncarcerationDetailsRecentServeState extends State<IncarcerationDetailsRecentServe> {
  final List<String> recentTerms = [
    "County Jail",
    "State Prison",
    "Federal Prison"
  ];

  String selected = "";
  OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.selectedServeMost;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "When were you first incarcerated?",
        ),
        Wrap(
          children: [
            for (var term in recentTerms)
              CustomOptionTile(
                title: term,
                isSelected: selected == term,
                onTap: () {
                  setState(() {
                    selected = term;
                     cubit.selectedServeMost=term;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
