import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProgramServiceProgramOfferSection extends StatefulWidget {
  ProgramServiceProgramOfferSection({super.key});

  @override
  State<ProgramServiceProgramOfferSection> createState() =>
      _ProgramServiceProgramOfferSectionState();
}

class _ProgramServiceProgramOfferSectionState
    extends State<ProgramServiceProgramOfferSection> {
  List<String> selectedProviders = [];

  final _controller = TextEditingController();

  ProviderOnboardingCubit get cubit => getIt();

  @override
  void initState() {
    super.initState();
    selectedProviders = cubit.programOffer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderOnboardingTitleWidget(
          title: "List the names of the different programs you offer",
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: "Enter Provider's name",
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            _addServiceProvider();
          },
        ),
        const SizedBox(height: 10),
        for (var provider in cubit.programOffer)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(provider),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {});
                    _removeServiceProvider();
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
        cubit.programOffer.add(_controller.text.trim());
        _generateSubFields();
        _controller.clear();
      });
    }
  }

  void _removeServiceProvider() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        cubit.programOffer.remove(_controller.text.trim());
        _generateSubFields();
        _controller.clear();
      });
    }
  }

  _generateSubFields(){
    cubit.programOffer=List.generate(cubit.programOffer.length, (index)=>"");
  }
}
