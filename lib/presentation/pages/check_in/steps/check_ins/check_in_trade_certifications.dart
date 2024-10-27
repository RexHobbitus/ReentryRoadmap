import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInTradeCertifications extends StatefulWidget {
  const CheckInTradeCertifications({super.key});

  @override
  State<CheckInTradeCertifications> createState() =>
      _CheckInTradeCertificationsState();
}

class _CheckInTradeCertificationsState
    extends State<CheckInTradeCertifications> {
  final List<String> certifications = [
    "None",
    "OSHA",
    "CDL",
    "HVAC",
    "Building Maintenance",
    "Plumbing",
    "ServSafe",
    "CNA",
  ];

  List<String> selected = [];

  CheckInCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selected = cubit.tradeCertifications;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "Do you have any trade certifications?",
          subTitle: "Select all that apply",
        ),
        Wrap(
          children: [
            for (var certificate in certifications)
              CustomOptionTile(
                title: certificate,
                isSelected: selected.contains(certificate),
                onTap: () {
                  setState(() {
                    if (selected.contains(certificate)) {
                      selected.remove(certificate);
                    } else {
                      selected.add(certificate);
                    }
                  });
                   cubit.tradeCertifications = selected;
                   cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
