import 'package:flutter/material.dart';
import 'package:reentry_roadmap/domain/entities/career.dart';
import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class CurrentNeedsCurrentCareer extends StatefulWidget {
  const CurrentNeedsCurrentCareer({super.key});

  @override
  State<CurrentNeedsCurrentCareer> createState() =>
      _CurrentNeedsCurrentCareerState();
}

class _CurrentNeedsCurrentCareerState extends State<CurrentNeedsCurrentCareer> {
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

  Career? selected;

  OnboardingCubit get cubit => getIt();
  bool isNone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.currentCareer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What kind of career do you currently have?"
        ),
        Wrap(
          children: [
            for (var career in careers)
              CustomOptionTile(
                title: career.title ?? "",
                subTitle: career.subTitle ?? "",
                isSelected: selected == career,
                onTap: () {
                  setState(() {
                    selected = career;
                  });
                  cubit.currentCareer = career;
                  cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
