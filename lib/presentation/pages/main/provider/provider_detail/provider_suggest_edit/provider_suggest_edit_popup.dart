import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../widgets/custom_title_card.dart';
import '../../../../../widgets/operating_hours_widget.dart';

class ProviderSuggestEditPopup extends StatefulWidget {
  final Provider provider;
  const ProviderSuggestEditPopup({super.key,required this.provider});

  @override
  State<ProviderSuggestEditPopup> createState() =>
      _ProviderSuggestEditPopupState();
}

class _ProviderSuggestEditPopupState extends State<ProviderSuggestEditPopup> {
  bool providerStillOpen = true;
  Provider get _provider=> widget.provider;
  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return SizedBox(
        width: deviceSize == DeviceSize.web ? 600 : null,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Is this provider still open?",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      CustomCheckBox(
                        key: UniqueKey(),
                        value: providerStillOpen,
                        onChange: (val) {
                          setState(() {
                            providerStillOpen = !providerStillOpen;
                          });
                        },
                        text: "Yes",
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomCheckBox(
                        value: !providerStillOpen,
                        key: UniqueKey(),
                        onChange: (val) {
                          setState(() {
                            providerStillOpen = !providerStillOpen;
                          });
                        },
                        text: "No",
                      ),
                    ],
                  ),
                  CustomTitleCard(
                    title: "Provider Details",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: "Name of the provider location",
                          initialValue: _provider.onboardingInfo?.providerDetails?.providerNameLocation,
                        ),
                        CustomTextField(
                          label: "Name of the parent location",
                          initialValue: _provider.onboardingInfo?.providerDetails?.providerLocationDescribe,
                        ),
                        CustomTextField(
                          label: "Relation to reentry",
                          initialValue: _provider.onboardingInfo?.providerDetails?.relationReentry,
                        ),
                        _label("Location"),
                        CustomTextField(
                          label: "Street",
                          initialValue: _provider.onboardingInfo?.providerDetails?.street,
                        ),
                        CustomTextField(
                          label: "City",
                          initialValue: _provider.onboardingInfo?.providerDetails?.city,
                        ),
                        CustomTextField(
                          label: "Country",
                          disable: true,
                          initialValue: _provider.onboardingInfo?.providerDetails?.country,
                          key: UniqueKey(),
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                setState(() {});
                              },
                            );
                          },
                        ),
                        CustomTextField(
                          label: "Zipcode",
                          initialValue: _provider.onboardingInfo?.providerDetails?.zipCode,
                        ),
                        _label("Operating Hours"),
                        OperatingHoursWidget(
                          operatingHours: _provider.onboardingInfo?.providerDetails?.operatingHours,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          label: "Organization website",
                          initialValue: _provider.onboardingInfo?.providerDetails?.orgWebsite,
                        ),
                        const  SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomButton(
                text: "Suggest Edits",
                onTap: () {},
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _label(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style:
            context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suggest an Edit",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your suggestions will be verified by us before we make a change",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.secondaryFixed),
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
          ],
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
