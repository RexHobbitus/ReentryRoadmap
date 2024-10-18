import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';

class ProgramServiceAmazingSauceSubcatagorySection extends StatefulWidget {
  final int index;
  const ProgramServiceAmazingSauceSubcatagorySection({super.key,required this.index});

  @override
  State<ProgramServiceAmazingSauceSubcatagorySection> createState() =>
      _ProgramServiceAmazingSauceSubcatagorySectionState();
}

class _ProgramServiceAmazingSauceSubcatagorySectionState
    extends State<ProgramServiceAmazingSauceSubcatagorySection> {
  List<String> selected = [];
  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.amazingSauceSubCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingTitleWidget(
          title: "What type of offence were you incarcerated for?",
          subTitle: "Select all that apply",
        ),
        Wrap(
          children: [
            for (var subCategory in kCommunitySubCategories)
              CustomOptionTile(
                title: subCategory,
                isSelected: selected.contains(subCategory),
                onTap: () {
                  setState(() {
                    if (selected.contains(subCategory)) {
                      selected.remove(subCategory);
                    } else {
                      selected.add(subCategory);
                    }
                  });
                  cubit.amazingSauceSubCategories = selected;
                  cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
