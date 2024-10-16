import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceAmazingProgramFeaturesSection extends StatefulWidget {
  ProgramServiceAmazingProgramFeaturesSection({super.key});

  @override
  State<ProgramServiceAmazingProgramFeaturesSection> createState() =>
      _ProgramServiceAmazingProgramFeaturesSectionState();
}

class _ProgramServiceAmazingProgramFeaturesSectionState
    extends State<ProgramServiceAmazingProgramFeaturesSection> {
  List<String> selectedFeatures = [];
  final _controller = TextEditingController();
  bool showAddButton = false; // Track whether the add button should be shown

  OnboardingCubit get cubit => getIt();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "What Program Features are you interested in?",
        ),

        // Text field for adding a new feature
        TypeAheadField<String>(
          suggestionsCallback: _onSearch,
          controller: _controller,
          builder: (context, controller, focusNode) {
            return CustomTextField(
              controller: controller,
              label: "Enter Program Feature",
              autoFocus: true,
              bottomPadding: 10,
              focusNode: focusNode,
            );
          },
          itemBuilder: (context, feature) {
            return ListTile(
              title: Text(
                feature,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            );
          },
          onSelected: (feature) {
            if (!selectedFeatures.contains(feature)) {
              setState(() {
                selectedFeatures.add(feature);
                _controller.clear(); // Clear the input field after selection
                showAddButton = true; // Show the add button after a selection
              });
            }
          },
        ),
        const SizedBox(height: 10),

        // Show the "Add Another Feature" button only after selecting a feature
        if (showAddButton)
          ElevatedButton(
            onPressed: () {
              setState(() {
                showAddButton = false; // Hide the button after pressing it
              });
            },
            child: const Text("Add Another Feature"),
          ),

        // Display selected features
        for (var feature in selectedFeatures)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.colorScheme.tertiaryContainer, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text(
                feature,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      selectedFeatures.remove(feature);
                      cubit.notifyTextFieldUpdates();
                    });
                  },
                  icon: SvgPicture.asset(Assets.delete)),
            ),
          ),

        CustomCheckBox(
          value: cubit.noServiceProviderAccessedSoFar,
          onChange: (val) {
            setState(() {
              if (val) {
                selectedFeatures.clear();
                cubit.notifyTextFieldUpdates();
              }
              cubit.noServiceProviderAccessedSoFar = val;
            });
          },
        )
      ],
    );
  }

  List<String> _onSearch(String value) {
    return kProgramFeatures
        .where((feature) => feature.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}

// Features (examples)
const List<String> kProgramFeatures = [
  'Local Hiring and Fair Minimum Wage',
  'Formerly Incarcerated Leadership',
  'Holistic Wraparound Services',
  'Youth Programs Available',
  'Voluntary',
  'In Custody Interview',
  'Award Winning',
  'Sober Living',
  'Afrocentric',
  'Partnered with SF Probation',
  'Faith Based',
  'Veteran Focused',
  'Food Provided',
  'ACA Accreditation',
  'Children Accepted',
  'In Custody Programs',
  'Restorative Approach',
  '6 Month Program',
  'All in One',
];
