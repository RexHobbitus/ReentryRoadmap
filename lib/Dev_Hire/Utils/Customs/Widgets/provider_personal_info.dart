import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reentry_roadmap/bloc/provider_info_bloc/provider_info_bloc.dart';
import 'package:reentry_roadmap/bloc/provider_info_bloc/provider_info_state.dart';
import '../../../../bloc/provider_info_bloc/provider_info_event.dart';
import '../TextField/custom_textfield.dart';

class ProviderPersonalInfo extends StatefulWidget {
  ProviderPersonalInfo({super.key});

  static const path = '/ProviderPersonalInfo';

  @override
  _ProviderPersonalInfoState createState() => _ProviderPersonalInfoState();
}

class _ProviderPersonalInfoState extends State<ProviderPersonalInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  final Map<String, TextEditingController> startControllers = {
    'Monday': TextEditingController(),
    'Tuesday': TextEditingController(),
    'Wednesday': TextEditingController(),
    'Thursday': TextEditingController(),
    'Friday': TextEditingController(),
    'Saturday': TextEditingController(),
    'Sunday': TextEditingController(),
  };

  final Map<String, TextEditingController> endControllers = {
    'Monday': TextEditingController(),
    'Tuesday': TextEditingController(),
    'Wednesday': TextEditingController(),
    'Thursday': TextEditingController(),
    'Friday': TextEditingController(),
    'Saturday': TextEditingController(),
    'Sunday': TextEditingController(),
  };

  Future<void> pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final formattedTime = "${picked.format(context)}";
      controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderInfoBloc, ProviderInfoState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.hasError) {
          return const Center(child: Text('Error loading provider info'));
        }

        final providerInfo = state.providerInfo;

        if (!state.isEditMode) {
          nameController.text = providerInfo['name'] ?? '';
          descriptionController.text = providerInfo['description'] ?? '';
          relationController.text = providerInfo['relation'] ?? '';
          locationController.text = providerInfo['location'] ?? '';
          cityController.text = providerInfo['city'] ?? '';
          countryController.text = providerInfo['country'] ?? '';
          stateController.text = providerInfo['state'] ?? '';
          zipCodeController.text = providerInfo['zipCode'] ?? '';
          websiteController.text = providerInfo['website'] ?? '';

          if (providerInfo['operatingHours'] != null) {
            providerInfo['operatingHours'].forEach((day, times) {
              startControllers[day]?.text = times['start'] ?? '';
              endControllers[day]?.text = times['end'] ?? '';
            });
          }
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffBFD4D9),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      height: 101,
                      decoration: const BoxDecoration(
                        color: Color(0xff11404C),
                      ),
                      child: Row(
                        children: [
                          Text('Personal Details',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              final updatedInfo = {
                                'name': nameController.text,
                                'description': descriptionController.text,
                                'relation': relationController.text,
                                'location': locationController.text,
                                'city': cityController.text,
                                'country': countryController.text,
                                'state': stateController.text,
                                'zipCode': zipCodeController.text,
                                'website': websiteController.text,
                                'operatingHours': {
                                  for (var day in startControllers.keys)
                                    day: {
                                      'start': startControllers[day]!.text,
                                      'end': endControllers[day]!.text,
                                    }
                                },
                              };

                              if (state.isEditMode) {
                                context
                                    .read<ProviderInfoBloc>()
                                    .add(UpdateProviderInfo(updatedInfo));
                              }
                              context
                                  .read<ProviderInfoBloc>()
                                  .add(ToggleEditMode());
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.edit,
                                    color: Colors.white, size: 20),
                                const Gap(4),
                                Text(
                                  state.isEditMode ? 'Save' : 'Edit',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hint: 'John Doe',
                            controller: nameController,
                            enabled: state.isEditMode,
                            lableText: 'Name',
                            hasLable: true,
                          ),
                          const Gap(12),
                          CustomTextField(
                            hint: 'Description of provider location',
                            controller: descriptionController,
                            enabled: state.isEditMode,
                            lableText: 'Description',
                            hasLable: true,
                            maxlines: 4,
                          ),
                          const Gap(12),
                          CustomTextField(
                            hint: 'Reentry Adjacent',
                            controller: relationController,
                            enabled: state.isEditMode,
                            lableText: 'Relation to Reentry',
                            hasLable: true,
                          ),
                          const Gap(12),
                          CustomTextField(
                            hint: '1234, La Jolla Village',
                            controller: locationController,
                            enabled: state.isEditMode,
                            lableText: 'Location',
                            hasLable: true,
                          ),
                          const Gap(12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hint: 'Hayward',
                                  controller: cityController,
                                  enabled: state.isEditMode,
                                  lableText: 'City',
                                  hasLable: true,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: CustomTextField(
                                  hint: 'Alameda',
                                  controller: countryController,
                                  enabled: state.isEditMode,
                                  lableText: 'Country',
                                  hasLable: true,
                                ),
                              ),
                            ],
                          ),
                          const Gap(12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hint: 'California',
                                  controller: stateController,
                                  enabled: state.isEditMode,
                                  lableText: 'State',
                                  hasLable: true,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: CustomTextField(
                                  hint: '1234',
                                  controller: zipCodeController,
                                  enabled: state.isEditMode,
                                  lableText: 'ZipCode',
                                  hasLable: true,
                                ),
                              ),
                            ],
                          ),
                          const Gap(12),
                          Text(
                            'Operating Hours',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const Gap(16),
                          ...startControllers.keys.map((day) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 21),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff97aaaa),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(day,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      onTap: () => state.isEditMode
                                          ? pickTime(startControllers[day]!)
                                          : null,
                                      child: AbsorbPointer(
                                        child: CustomTextField(
                                          hint: 'Start Time',
                                          controller: startControllers[day]!,
                                          enabled: state.isEditMode,
                                          hasLable: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(8),
                                  Text('to',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black)),
                                  const Gap(8),
                                  Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      onTap: () => state.isEditMode
                                          ? pickTime(endControllers[day]!)
                                          : null,
                                      child: AbsorbPointer(
                                        child: CustomTextField(
                                          hint: 'End Time',
                                          controller: endControllers[day]!,
                                          enabled: state.isEditMode,
                                          hasLable: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          const Gap(12),
                          CustomTextField(
                            hint: 'www.Opengatehayward.org',
                            controller: websiteController,
                            enabled: state.isEditMode,
                            lableText: 'Organization Website',
                            hasLable: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
