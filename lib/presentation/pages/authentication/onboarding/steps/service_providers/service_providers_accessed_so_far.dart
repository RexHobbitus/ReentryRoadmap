import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/onboarding/onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

import '../../widgets/onboarding_title_widget.dart';

class ServiceProvidersAccessedSoFar extends StatefulWidget {
  ServiceProvidersAccessedSoFar({super.key});

  @override
  State<ServiceProvidersAccessedSoFar> createState() =>
      _ServiceProvidersAccessedSoFarState();
}

class _ServiceProvidersAccessedSoFarState
    extends State<ServiceProvidersAccessedSoFar> {
  List<ServiceProvider> selectedProviders = [];

  final _controller = TextEditingController();

  OnboardingCubit get cubit => getIt();

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
        const OnboardingTitleWidget(
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
              leading: selected.icon == null
                  ? null
                  : CircleAvatar(
                      backgroundImage: AssetImage(selected.icon!),
                      radius: 20,
                    ),
              title: Text(
                selected.title.toString(),
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: selected.subTitle == null
                  ? null
                  : Text(
                      selected.subTitle.toString(),
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
        TypeAheadField<ServiceProvider>(
          suggestionsCallback: _onSearch,
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
                ServiceProvider newProvider =
                    ServiceProvider(title: _controller.text);
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
          itemBuilder: (context, service) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(service.icon!),
                radius: 20,
              ),
              title: Text(
                service.title.toString(),
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                service.subTitle.toString(),
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

  List<ServiceProvider> _onSearch(String value) {
    List<ServiceProvider> serviceProviders = [];
    for (var serviceProvider in _serviceProviders) {
      if (serviceProvider.title!.toLowerCase().contains(value.toLowerCase())) {
        serviceProviders.add(serviceProvider);
      }
    }
    return serviceProviders;
  }

  final List<ServiceProvider> _serviceProviders = [
    ServiceProvider(
        title: "OpenGate Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.serviceProviderOpenGate),
    ServiceProvider(
        title: "OpenHeart Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.serviceProviderOpenHeart),
    ServiceProvider(
        title: "OpenSky Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.serviceProviderOpenSky),
    ServiceProvider(
        title: "OpenDoor Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.serviceProviderOpenDoor),
  ];
}

class ServiceProvider extends Equatable {
  String? title;
  String? subTitle;
  String? icon;

  ServiceProvider({
    required this.title,
    this.subTitle,
    this.icon,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, subTitle, icon];
}
