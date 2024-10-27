import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import '../../../../../../domain/entities/career.dart';
import '../../../../../../service_locator/service_locator.dart';
import '../../widgets/check_in_title_widget.dart';

class CheckInFutureCareer extends StatefulWidget {
  const CheckInFutureCareer({super.key});

  @override
  State<CheckInFutureCareer> createState() =>
      _CheckInFutureCareerState();
}

class _CheckInFutureCareerState extends State<CheckInFutureCareer> {
  final List<Career> careers = [
    Career(
        title: "Service",
        subTitle: "Restaurants, healthcare, retail shops, etc"),
    Career(
        title: "Administrative/Office Support",
        subTitle: "Clerical work, data entry, reception, office management"),
    Career(
        title: "Labor/ Manufacturing",
        subTitle: "Factory work, construction, warehousing, etc"),
    Career(
        title: "Sales/Marketing",
        subTitle: "Sales roles, marketing positions, business development"),
    Career(
        title: "Skilled Trades",
        subTitle: "Electrical work, plumbing, carpentry, etc"),
    Career(
        title: "Information Technology (IT)",
        subTitle: "IT support, software development, technical services"),
  ];

  List<Career> selected = [];

  CheckInCubit get cubit => getIt();
  bool isNone = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.careersToPursue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "What kind of career would you like to pursue?",
          subTitle: "Select all that apply",
        ),
        Wrap(
          children: [
            for (var career in careers)
              CustomOptionTile(
                title: career.title ?? "",
                subTitle: career.subTitle ?? "",
                isSelected: selected.contains(career),
                onTap: () {
                  setState(() {
                    if (selected.contains(career)) {
                      selected.remove(career);
                    } else {
                      selected.add(career);
                    }
                  });
                   cubit.careersToPursue = selected;
                   cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
