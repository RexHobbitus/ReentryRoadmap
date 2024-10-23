import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceProgramOfferSection extends StatefulWidget {
  ProgramServiceProgramOfferSection({super.key});

  @override
  State<ProgramServiceProgramOfferSection> createState() =>
      _ProgramServiceProgramOfferSectionState();
}

class _ProgramServiceProgramOfferSectionState
    extends State<ProgramServiceProgramOfferSection> {
  List<String> selectedPrograms = [];

  final _controller = TextEditingController();

  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    super.initState();
    selectedPrograms = cubit.selectedPrograms
        .map((program) => program.name.toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "List the names of the different programs you offer",
        ),
        kIsWeb
            ? CustomTextField(
                width: double.infinity,
                controller: _controller,
                label: "Enter program name",
                onSubmit: (value) {
                  _addServiceProvider();
                },
              )
            : CustomTextField(
                controller: _controller,
                label: "Enter program name",
                onSubmit: (value) {
                  _addServiceProvider();
                },
              ),
        const SizedBox(height: 10),
        for (var programName in selectedPrograms)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(programName),
              trailing: IconButton(
                  onPressed: () {
                    _removeProgram(programName);
                  },
                  icon: SvgPicture.asset(Assets.delete)),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _addServiceProvider() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        selectedPrograms.add(_controller.text.trim());
        _controller.clear();
        _generateSubFields();
        cubit.notifyTextFieldUpdates();
      });
    }
  }

  void _removeProgram(String provider) {
    setState(() {
      selectedPrograms.remove(provider);
      _generateSubFields();
      cubit.notifyTextFieldUpdates();
    });
  }

  _generateSubFields() {
    cubit.selectedCategories =
        List.generate(selectedPrograms.length, (index) => []);
    cubit.selectedPrograms = List.generate(
      selectedPrograms.length,
      (index) => Program(
          name: selectedPrograms[index],
          description: "",
          programCategories: [],
          features: [],
          eligibilityCriteria: []),
    );
  }
}
