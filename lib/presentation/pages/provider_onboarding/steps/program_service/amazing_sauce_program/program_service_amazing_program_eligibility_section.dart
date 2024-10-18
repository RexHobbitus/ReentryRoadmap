import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceAmazingProgramEligibilitySection extends StatefulWidget {
  ProgramServiceAmazingProgramEligibilitySection({super.key});

  @override
  State<ProgramServiceAmazingProgramEligibilitySection> createState() =>
      _ProgramServiceAmazingProgramEligibilitySectionState();
}

class _ProgramServiceAmazingProgramEligibilitySectionState
    extends State<ProgramServiceAmazingProgramEligibilitySection> {
  final _controller = TextEditingController();
  bool showAddButton = false; // Track whether the add button should be shown

  ProviderOnboardingCubit get cubit => getIt();

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
          title: "Enter the eligibility criteria for the program",
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
            return Column(
              children: [
                ListTile(
                  title: Text(
                    feature,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 2,
                  ),
                )
              ],
            );
          },
          onSelected: (feature) {
            if (!cubit.amazingSauceEligibilityCriteria.contains(feature)) {
              setState(() {
                cubit.amazingSauceEligibilityCriteria.add(feature);
                _controller.clear();
                showAddButton = true;
              });
            }
          },
        ),
        const SizedBox(height: 10),

        // Display selected features
        for (var feature in cubit.amazingSauceEligibilityCriteria)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.colorScheme.tertiaryContainer, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    feature,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          cubit.amazingSauceEligibilityCriteria.remove(feature);
                          cubit.notifyTextFieldUpdates();
                        });
                      },
                      icon: SvgPicture.asset(Assets.delete)),
                ),
              ],
            ),
          ),
        // Show the "Add Another Feature" button only after selecting a feature

        TextButton(
          onPressed: () {
            setState(() {
              showAddButton = false; // Hide the button after pressing it
            });
          },
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: context.colorScheme.secondary,
              ),
              Text(
                "Add Another Feature",
                style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> _onSearch(String value) {
    return kEligibilityCriteria
        .where((feature) => feature.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}
