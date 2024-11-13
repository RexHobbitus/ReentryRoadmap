import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:reentry_roadmap/core/extensions/media_query_extension.dart';
import '../../../bloc/program_details_bloc/program_details_bloc.dart';
import '../../../bloc/program_details_bloc/program_details_event.dart';
import '../../../bloc/program_details_bloc/program_details_state.dart';
import '../../../core/utils/assets.dart';
import '../../widgets/customize_svg_widget.dart';
import '../../widgets/text_widgets.dart';

class ProgramDetailsScreen extends StatefulWidget {
  const ProgramDetailsScreen({super.key});

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  final List<Map<String, String>> items = [
    {'icon': Assets.claimYourBusiness, 'label': 'Education'},
    {'icon': Assets.claimYourBusiness, 'label': 'Employment'},
    {'icon': Assets.claimYourBusiness, 'label': 'Housing'},
    {'icon': Assets.claimYourBusiness, 'label': 'Life Skills'},
    {'icon': Assets.claimYourBusiness, 'label': 'Finance'},
    {'icon': Assets.claimYourBusiness, 'label': 'Legal'},
    {'icon': Assets.claimYourBusiness, 'label': 'Transportation'},
    {'icon': Assets.claimYourBusiness, 'label': 'Community'},
    {'icon': Assets.claimYourBusiness, 'label': 'Health'},
    {'icon': Assets.claimYourBusiness, 'label': 'Friends & Family'},
    {'icon': Assets.claimYourBusiness, 'label': 'Spirituality'},
    {'icon': Assets.claimYourBusiness, 'label': 'Mental Health'},
    {'icon': Assets.claimYourBusiness, 'label': 'First Steps'},
  ];

  final Map<String, int?> selectedIndicesByCategory = {
    'education': null,
    'employment': null,
    'generalServices': null,
  };

  final Map<String, List<String>> categoryItems = {
    'education': [
      'Adult Education',
      'Vocational Training',
      'Higher Education',
      'GED Courses',
    ],
    'employment': [
      'Job Placement Services',
      'Career Counseling',
      'Apprenticeships and Internships',
      'Resume Building',
      'Soft Skills',
      'Second Chance Employer',
    ],
    'generalServices': [
      'None',
      'Local Hiring and Fair Minimum Wage',
      'Sober Living',
      'In Custody Interview',
      'Formerly Incarcerated Leadership',
      'Youth Programs Available',
      'Award Winning',
      'Holistic Wraparound Services',
      'Partnered with SF Probation',
      'Veteran Focused'
    ],
  };

  final List<String> options = [
    'Within 5 Years of Incarceration',
    'Within 10 Years of Incarceration',
    'No Restriction',
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProgramDetailsBloc>().add(LoadProgramDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramDetailsBloc, ProgramDetailsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        log("State data is ${state.data} type is ${state.data.runtimeType}");

        return ListView.separated(
          itemCount: state.data!.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (itemBuilder, index) {
            bool isFirstItem = index == 0;
            bool isEditing = state.isEditing[index] ?? false;
            final itemData = state.data![index];
            log("Item data is $itemData");
            final selectedItems =
                Set<int>.from(itemData['selectedItems'] ?? []);

            final selectedIndicesByCategory = Map<String, int?>.from(
                itemData['selectedIndicesByCategory'] ?? {});
            final selectedCriteria =
                List<String?>.from(itemData['selectedCriteria'] ?? []);

            return Container(
              padding: const EdgeInsets.all(14),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffBFD4D9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    width: context.screenWidth,
                    height: 101,
                    decoration: const BoxDecoration(
                      color: Color(0xff11404C),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const TextWidget(
                            title:
                                "All Categories that apply to general services",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          if (!isFirstItem) // Show Edit option only if not the first item
                            GestureDetector(
                              onTap: () {
                                if (isEditing) {
                                  // Save changes
                                  final itemData = state.data![index];
                                  final documentId = itemData['documentId'];
                                  context.read<ProgramDetailsBloc>().add(
                                        UpdateProgramDetails(
                                            documentId, itemData),
                                      );
                                }

                                context
                                    .read<ProgramDetailsBloc>()
                                    .add(ToggleEditMode(index));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    isEditing
                                        ? Icons.save
                                        : Icons.edit, // Toggle icon
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const Gap(4),
                                  TextWidget(
                                    title: isEditing ? 'Save' : 'Edit',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(items.length, (i) {
                      final item = items[i];
                      final isSelected = selectedItems.contains(i);

                      return GestureDetector(
                        onTap: () {
                          context
                              .read<ProgramDetailsBloc>()
                              .add(UpdateSelectedItems(index, i));
                        },
                        child: Container(
                          width: context.screenWidth < 600
                              ? context.screenWidth / 2 - 20
                              : 150,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff11404C)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xff11404C)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SvgImageWidget(
                                assetPath: item['icon']!,
                                height: context.screenHeight * 0.1,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['label']!,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  _buildCategorySection(
                    'All categories under education',
                    'education',
                    itemData,
                    index,
                  ),
                  const SizedBox(height: 20),
                  _buildCategorySection('All categories under employment',
                      'employment', itemData, index),
                  const SizedBox(height: 20),
                  _buildCategorySection('Features of general services',
                      'generalServices', itemData, index),
                  const SizedBox(height: 20),
                  const Text(
                    'Eligibility criteria for general services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children:
                        List.generate(selectedCriteria.length, (criteriaIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: selectedCriteria[criteriaIndex],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          items: options.map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value) {
                            context.read<ProgramDetailsBloc>().add(
                                  UpdateSelectedCriteria(
                                      index, criteriaIndex, value),
                                );
                          },
                          hint: const Text("Select criteria"),
                        ),
                      );
                    }),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<ProgramDetailsBloc>()
                          .add(AddDropdownCriteria(index));
                    },
                    child: const Text(
                      '+ Add Another',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isFirstItem)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ProgramDetailsBloc>()
                                    .add(SaveProgramDetails());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF9370DB), // Lavender color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                              ),
                              child: const Text(
                                '+ Add a Program',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: context.screenHeight * 0.02,
            );
          },
        );
      },
    );
  }

  Widget _buildCategorySection(String title, String categoryKey,
      Map<String, dynamic> itemData, int index) {
    final items = categoryItems[categoryKey] ?? [];
    final selectedIndicesByCategory = Map<String, int?>.from(
      itemData['selectedIndicesByCategory'] ??
          {
            'education': null,
            'employment': null,
            'generalServices': null,
          },
    );

    final selectedIndex = selectedIndicesByCategory[categoryKey];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(items.length, (itemIndex) {
            final isSelected = selectedIndex == itemIndex;
            return GestureDetector(
              onTap: () {
                context.read<ProgramDetailsBloc>().add(
                      UpdateCategorySelection(index, categoryKey, itemIndex),
                    );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xff11404C)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  items[itemIndex],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
