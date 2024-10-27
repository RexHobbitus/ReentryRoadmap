import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInServiceProviderType extends StatefulWidget {
  const CheckInServiceProviderType({super.key});

  @override
  State<CheckInServiceProviderType> createState() =>
      _CheckInServiceProviderTypeState();
}

class _CheckInServiceProviderTypeState
    extends State<CheckInServiceProviderType> {
  final List<String> serviceProviderSizes = [
    "Small (0-50)",
    "Medium (50-250)",
    "Large (250+)"
  ];

  String selected = "";
  CheckInCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.selectedServiceProviderSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
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
                    cubit.selectedServiceProviderSize = size;
                    cubit.notifyTextFieldUpdates();
                  });
                },
              ),
          ],
        )
      ],
    );
  }
}
