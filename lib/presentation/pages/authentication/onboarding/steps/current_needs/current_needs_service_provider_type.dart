import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../widgets/onboarding_title_widget.dart';


class CurrentNeedsServiceProviderType extends StatefulWidget {
  const CurrentNeedsServiceProviderType({super.key});

  @override
  State<CurrentNeedsServiceProviderType> createState() => _CurrentNeedsServiceProviderTypeState();
}

class _CurrentNeedsServiceProviderTypeState extends State<CurrentNeedsServiceProviderType> {
  final List<String> serviceProviderSizes = [
    "Small (0-50)",
    "Medium (50-250)",
    "Large (250+)"
  ];

  String selected = "";
  // OnboardingCubit get cubit  => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected=cubit.selectedIncarceratedHistory;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "Do you prefer large or small service providers",
        ),
        Wrap(
          children: [
            for (var size in serviceProviderSizes)
              CustomOptionTile(
                title: size,
                isSelected: selected == size,
                onTap: () {
                  setState(() {
                    selected = size;
                    // cubit.selectedIncarceratedHistory=history;
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
