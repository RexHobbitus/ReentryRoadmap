import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceProgramOfferFeaturesSection extends StatefulWidget {
  final int index;
  ProgramServiceProgramOfferFeaturesSection({super.key,required this.index});

  @override
  State<ProgramServiceProgramOfferFeaturesSection> createState() =>
      _ProgramServiceProgramOfferFeaturesSectionState();
}

class _ProgramServiceProgramOfferFeaturesSectionState
    extends State<ProgramServiceProgramOfferFeaturesSection> {
  final _controller = TextEditingController();
  bool showAddButton = false; 
  ProviderOnboardingCubit get cubit => getIt();
  List<String> selectedFeatures=[];

  @override
  void initState() {
    super.initState();
    selectedFeatures=cubit.selectedPrograms[widget.index].features??[];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "Enter a few features of the program",
        ),

        TypeAheadField<String>(
          suggestionsCallback: _onSearch,
          controller: _controller,
          builder: (context, controller, focusNode) {
            return 
            
            kIsWeb?
            CustomTextField(
              width: double.infinity,
              controller: controller,
              label: "Enter Program Feature",
              autoFocus: true,
              bottomPadding: 10,
              focusNode: focusNode,
            ):
                        CustomTextField(
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
            if (!selectedFeatures.contains(feature)) {
              setState(() {
                selectedFeatures.add(feature);
                cubit.selectedPrograms[widget.index].features=selectedFeatures;
                _controller.clear();
                showAddButton = true;
                _checkEnableNextForThisSection();
              });
            }
          },
        ),
        const SizedBox(height: 10),

        for (var feature in selectedFeatures)
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
                          selectedFeatures.remove(feature);
                          cubit.selectedPrograms[widget.index].features=selectedFeatures;
                          _checkEnableNextForThisSection();

                        });
                      },
                      icon: SvgPicture.asset(Assets.delete)),
                ),
              ],
            ),
          ),

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
    return kProgramFeatures
        .where((feature) => feature.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  void _checkEnableNextForThisSection() {
    if(selectedFeatures.isNotEmpty){
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }

}
