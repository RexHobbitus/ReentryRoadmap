import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/widgets/onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../../../../widgets/custom_option_tile.dart';

class ProgramServiceSubcatagorySection extends StatefulWidget {
  const ProgramServiceSubcatagorySection({super.key});

  @override
  State<ProgramServiceSubcatagorySection> createState() =>
      _ProgramServiceSubcatagorySectionState();
}

class _ProgramServiceSubcatagorySectionState
    extends State<ProgramServiceSubcatagorySection> {
  List<String> selected = [];
  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = cubit.subCategories;
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
                  cubit.subCategories = selected;
                  cubit.notifyTextFieldUpdates();
                },
              ),
          ],
        )
      ],
    );
  }
}
