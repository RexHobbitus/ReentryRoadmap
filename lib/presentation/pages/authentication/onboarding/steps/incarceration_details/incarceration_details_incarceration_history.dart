import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';

class IncarcerationDetailsIncarcerationHistory extends StatefulWidget {
  const IncarcerationDetailsIncarcerationHistory({super.key});

  @override
  State<IncarcerationDetailsIncarcerationHistory> createState() => _IncarcerationDetailsIncarcerationHistoryState();
}

class _IncarcerationDetailsIncarcerationHistoryState extends State<IncarcerationDetailsIncarcerationHistory> {
  final List<String> historyOptions = [
    "In and Out my entire life",
    "One long time",
    "A few times"
  ];

  String selected = "";
  OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected=cubit.selectedIncarceratedHistory;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How many times have you been incarcerated?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),

        Wrap(
          children: [
            for (var history in historyOptions)
              CustomOptionTile(
                title: history,
                isSelected: selected == history,
                onTap: () {
                  setState(() {
                    selected = history;
                    cubit.selectedIncarceratedHistory=history;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
