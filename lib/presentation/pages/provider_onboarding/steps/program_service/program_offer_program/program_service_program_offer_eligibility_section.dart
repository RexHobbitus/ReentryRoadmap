import 'package:flutter/foundation.dart';
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

class ProgramServiceProgramOfferEligibilitySection extends StatefulWidget {
  final int index;
  ProgramServiceProgramOfferEligibilitySection(
      {super.key, required this.index});

  @override
  State<ProgramServiceProgramOfferEligibilitySection> createState() =>
      _ProgramServiceProgramOfferEligibilitySectionState();
}

class _ProgramServiceProgramOfferEligibilitySectionState
    extends State<ProgramServiceProgramOfferEligibilitySection> {
  final _controller = TextEditingController();
  bool showAddButton = false; // Track whether the add button should be shown

  ProviderOnboardingCubit get cubit => getIt();

  List<String> selectedEligibilityCriteria = [];
  @override
  void initState() {
    super.initState();
    selectedEligibilityCriteria =
        cubit.selectedPrograms[widget.index].eligibilityCriteria ?? [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    cubit.currentProgramIndex=widget.index;
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
            return kIsWeb
                ? CustomTextField(
                    width: double.infinity,
                    controller: controller,
                    label: "Enter Program Feature",
                    autoFocus: true,
                    bottomPadding: 10,
                    focusNode: focusNode,
                  )
                : CustomTextField(
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
            if (!selectedEligibilityCriteria.contains(feature)) {
              setState(() {
                selectedEligibilityCriteria.add(feature);
                cubit.selectedPrograms[widget.index].eligibilityCriteria =
                    selectedEligibilityCriteria;
                _checkEnableNextForThisSection();
                _controller.clear();

                showAddButton = true;
              });
            }
          },
        ),
        const SizedBox(height: 10),

        // Display selected features
        for (var feature in selectedEligibilityCriteria)
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
                          selectedEligibilityCriteria.remove(feature);
                          cubit.selectedPrograms[widget.index]
                                  .eligibilityCriteria =
                              selectedEligibilityCriteria;
                          _checkEnableNextForThisSection();
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

  void _checkEnableNextForThisSection() {
    if(selectedEligibilityCriteria.isNotEmpty){
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }


}
