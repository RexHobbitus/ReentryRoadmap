import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/create_provider/create_provider_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/create_provider/create_provider_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/create_provider/widgets/create_provider_operation_hours.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_drop_down.dart';

class CreateProviderPage extends StatefulWidget {
  final CreateProviderCubit cubit;
  final CreateProviderInitialParams initialParams;
  static const path = '/CreateProviderPage';

  const CreateProviderPage(
      {super.key, required this.cubit, required this.initialParams});

  @override
  _CreateProviderPageState createState() => _CreateProviderPageState();
}

class _CreateProviderPageState extends State<CreateProviderPage> {
  CreateProviderCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        leading: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kScreenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add a Provider",
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.close)),
                    ),
                  ],
                ),
                Text(
                  "Please enter your login credentials to explore app features.",
                  style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.secondary),
                ),
              ],
            ),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kScreenHorizontalPadding),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  "Provider Details",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: context.colorScheme.tertiaryContainer.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Name of the provider location",
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: widget.cubit.name,
                    ),
                    Text(
                      "Name of the parent location",
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: widget.cubit.parentLocation,
                    ),
                    Text(
                      "Relation to reentry",
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: widget.cubit.reentry,
                    ),
                    Text(
                      "Location",
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          return Wrap(
                            spacing: 10,
                            children: [
                              CustomTextField(
                                width: double.infinity,
                                initialValue: cubit.locationStreet,
                                onChange: (val) {
                                  cubit.locationStreet = val;
                                  cubit.notifyTextFieldUpdates();
                                },
                                label: "Street Address",
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      initialValue: cubit.locationCity,
                                      onChange: (val) {
                                        cubit.locationCity = val;
                                        // cubit.notifyTextFieldUpdates();
                                      },
                                      label: "City",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      initialValue: cubit.locationCountry,
                                      onChange: (val) {
                                        cubit.locationCountry = val;
                                        cubit.notifyTextFieldUpdates();
                                      },
                                      label: "Country",
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomDropDown<String>(
                                      items: kUSStates,
                                      selectedItem: cubit.locationState.isEmpty
                                          ? null
                                          : cubit.locationState,
                                      onChange: (state) {
                                        cubit.locationState = state ?? "";
                                        cubit.notifyTextFieldUpdates();
                                      },
                                      label: "State",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      height: 90,
                                      initialValue: cubit.locationZipCode,
                                      onChange: (val) {
                                        cubit.locationZipCode = val;
                                        cubit.notifyTextFieldUpdates();
                                      },
                                      label: "Zip Code",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Wrap(
                            spacing: 10,
                            children: [
                              CustomTextField(
                                initialValue: cubit.locationStreet,
                                onChange: (val) {
                                  cubit.locationStreet = val;
                                  cubit.notifyTextFieldUpdates();
                                },
                                label: "Street Address (optional)",
                              ),
                              CustomTextField(
                                initialValue: cubit.locationCity,
                                onChange: (val) {
                                  cubit.locationCity = val;
                                  cubit.notifyTextFieldUpdates();
                                },
                                label: "City",
                              ),
                              CustomTextField(
                                initialValue: cubit.locationCountry,
                                onChange: (val) {
                                  cubit.locationCountry = val;
                                  cubit.notifyTextFieldUpdates();
                                },
                                label: "Country",
                              ),
                              CustomDropDown<String>(
                                items: kUSStates,
                                selectedItem: cubit.locationState.isEmpty
                                    ? null
                                    : cubit.locationState,
                                onChange: (state) {
                                  cubit.locationState = state ?? "";
                                  cubit.notifyTextFieldUpdates();
                                },
                                label: "State",
                              ),
                              CustomTextField(
                                initialValue: cubit.locationZipCode,
                                onChange: (val) {
                                  cubit.locationZipCode = val;
                                  cubit.notifyTextFieldUpdates();
                                },
                                label: "Zip Code",
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 6),
                    CreateProviderOperatingHours(),
                    const SizedBox(height: 10),
                    Text(
                      "Organization website",
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: widget.cubit.website,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: "Add Provider",
              onTap: widget.cubit.showProviderLocationDialog,
            ),
          ],
        ),
      ),
    );
  }
}
