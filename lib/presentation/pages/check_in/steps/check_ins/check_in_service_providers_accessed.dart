import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_details_info.dart';
import 'package:reentry_roadmap/domain/entities/provider_onboarding_info.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/widgets/check_in_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../../../../../domain/entities/service_provider.dart';

class CheckInServiceProvidersAccessed extends StatefulWidget {
  const CheckInServiceProvidersAccessed({super.key});

  @override
  State<CheckInServiceProvidersAccessed> createState() =>
      _CheckInServiceProvidersAccessedState();
}

class _CheckInServiceProvidersAccessedState
    extends State<CheckInServiceProvidersAccessed> {
  List<Provider> selectedProviders = [];

  final _controller = TextEditingController();

  CheckInCubit get cubit => getIt();
  CheckInState get state => cubit.state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedProviders = cubit.selectedProviders;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckInTitleWidget(
          title: "What Service Providers have you accessed so far?",
        ),
        for (var selected in selectedProviders)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.colorScheme.tertiaryContainer, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: context.colorScheme.secondary,
                radius: 20,
                child: Text(selected.onboardingInfo!.providerDetails!.providerNameLocation!.substring(0, 2).toUpperCase()),
              ),
              title: Text(
                selected.onboardingInfo!.providerDetails!.providerNameLocation.toString(),
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: selected.completeAddress==""
                  ? null
                  : Text(
                selected.completeAddress.toString(),
                      style: context.textTheme.bodySmall,
                    ),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      selectedProviders.remove(selected);
                      cubit.selectedProviders = selectedProviders;
                      cubit.notifyTextFieldUpdates();
                    });
                  },
                  icon: SvgPicture.asset(Assets.delete)),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        TypeAheadField<Provider>(
          suggestionsCallback: cubit.getMatchingProviders,
          controller: _controller,
          builder: (context, controller, focusNode) {
            return CustomTextField(
              controller: controller,
              label: "Enter Provider's name",
              autoFocus: true,
              bottomPadding: 10,
              focusNode: focusNode,
            );
          },
          emptyBuilder: (context) {
            return InkWell(
              onTap: () {
                Provider newProvider = Provider(onboardingInfo: ProviderOnboardingInfo(
                  providerDetails: ProviderDetailsInfo(
                    providerNameLocation: _controller.text,
                  )
                ));
                if (!selectedProviders.contains(newProvider)) {
                  setState(() {
                    _controller.text = "";
                    selectedProviders.add(newProvider);
                    cubit.selectedProviders = selectedProviders;
                    cubit.notifyTextFieldUpdates();
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.text,
                          style: context.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "+ Add Provider",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemBuilder: (context, provider) {
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: context.colorScheme.secondary,
                child: Text("${provider.onboardingInfo!.providerDetails!.providerNameLocation}".toUpperCase().substring(0, 2)),
              ),
              title: Text(
                "${provider.onboardingInfo!.providerDetails!.providerNameLocation}",
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                provider.completeAddress,
                style: context.textTheme.bodySmall,
              ),
            );
          },
          onSelected: (service) {
            if (!selectedProviders.contains(service)) {
              setState(() {
                selectedProviders.add(service);
                cubit.selectedProviders = selectedProviders;
                cubit.notifyTextFieldUpdates();
              });
            }
          },
        ),
        CustomCheckBox(
          value: cubit.noServiceProviderAccessedSoFar,
          onChange: (val) {
            setState(() {
              if (val) {
                selectedProviders.clear();
                cubit.selectedProviders = selectedProviders;
              }
              cubit.noServiceProviderAccessedSoFar = val;
              cubit.notifyTextFieldUpdates();
            });
          },
        )
      ],
    );
  }


}
