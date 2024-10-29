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

class ProgramServiceGeneralServiceFeaturesSection extends StatefulWidget {
  ProgramServiceGeneralServiceFeaturesSection({super.key});

  @override
  State<ProgramServiceGeneralServiceFeaturesSection> createState() =>
      _ProgramServiceGeneralServiceFeaturesSectionState();
}

class _ProgramServiceGeneralServiceFeaturesSectionState
    extends State<ProgramServiceGeneralServiceFeaturesSection> {
  final _controller = TextEditingController();
  bool showAddButton = false; // Track whether the add button should be shown

  ProviderOnboardingCubit get cubit => getIt();

  List<String> features=[];

  @override
  void initState() {
    super.initState();
    features=cubit.generalServiceInfo.features??[];
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
            if (!features.contains(feature)) {
              setState(() {
                features.add(feature);
                cubit.generalServiceInfo.features=features;
                _controller.clear();
                showAddButton = true;
                _checkEnableNextForThisSection();
              });
            }
          },
        ),
        const SizedBox(height: 10),

        for (var feature in features)
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
                          features.remove(feature);
                          cubit.generalServiceInfo.features=features;
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
              showAddButton = false;
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
    if(features.isNotEmpty){
      cubit.isNextButtonEnabled.value = true;
      return;
    }
    cubit.isNextButtonEnabled.value = false;
  }


}
