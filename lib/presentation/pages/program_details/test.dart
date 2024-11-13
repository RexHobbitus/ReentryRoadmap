import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reentry_roadmap/core/extensions/media_query_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/customize_svg_widget.dart';

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

  // Set to keep track of selected items
  final Set<int> selectedItems = {};

  final Map<String, int?> selectedIndicesByCategory = {
    'education': null,
    'employment': null,
    'generalServices': null,
  };

  // Sample data for each category
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

  List<String?> selectedCriteria = [
    null
  ]; // Initial list with one dropdown selection
  final List<String> options = [
    'Within 5 Years of Incarceration',
    'Within 10 Years of Incarceration',
    'No Restriction',
  ];

  void addDropdown() {
    setState(() {
      selectedCriteria.add(null);
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Validation method
  bool validateSelections() {
    return selectedItems.isNotEmpty &&
        selectedIndicesByCategory.values.any((index) => index != null) &&
        selectedCriteria.any((criteria) => criteria != null);
  }

  // Save or Update Data
  Future<void> saveProgramDetails() async {
    if (!validateSelections()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
      return;
    }

    // Prepare data for Firestore
    final programData = {
      'selectedItems': selectedItems.toList(),
      'selectedIndicesByCategory': selectedIndicesByCategory,
      'selectedCriteria': selectedCriteria,
    };

    try {
      // Save or update document
      await _firestore
          .collection('program_details')
          .doc('unique_user_id') // Replace with unique identifier if needed
          .set(programData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Program details saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save program details.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('program_details')
          .doc('unique_user_id')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          selectedItems.addAll(List<int>.from(data['selectedItems'] ?? []));
          data['selectedIndicesByCategory']?.forEach((key, value) {
            selectedIndicesByCategory[key] = value;
          });
          selectedCriteria = List<String?>.from(data['selectedCriteria'] ?? []);

          return buildContent();
        }
        return buildContent();
      },
    );
  }

  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffBFD4D9)),
          child: Center(
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
                  child: Row(
                    children: [
                      Text('General Service',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 20)),
                      const Spacer(),
                      // const Icon(
                      //   Icons.edit,
                      //   color: Colors.white,
                      //   size: 20,
                      // ),
                      const Gap(4),
                      // const TextWidget(
                      //   title: 'Edit',
                      //   fontWeight: FontWeight.w500,
                      //   color: Colors.white,
                      //   decoration: TextDecoration.underline,
                      //   fontSize: 15,
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        title: "All Categories that apply to general services",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        alignment: WrapAlignment.start,
                        children: List.generate(items.length, (index) {
                          final item = items[index];
                          final isSelected = selectedItems.contains(index);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedItems.remove(index);
                                } else {
                                  selectedItems.add(index);
                                }
                              });
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
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgImageWidget(
                                    assetPath: item['icon']!,
                                    height: context.screenHeight * 0.1,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  TextWidget(
                                    title: item['label']!,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      buildCategorySection(
                          'All categories under education', 'education'),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      buildCategorySection(
                          'All categories under employment', 'employment'),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      buildCategorySection(
                          'Features of general services', 'generalServices'),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      const Text(
                        'Eligibility criteria for general services',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // List of Dropdowns
                      Column(
                        children:
                            List.generate(selectedCriteria.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Builder(
                              builder: (BuildContext context) {
                                return DropdownButtonFormField<String>(
                                  value: selectedCriteria[index],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: options.map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCriteria[index] = value;
                                    });
                                    // Navigator.of(context).pushNamed('/test12');
                                  },
                                  hint: const Text("Select criteria"),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                      // Add Another button
                      TextButton(
                        onPressed: addDropdown,
                        child: const Text(
                          '+ Add Another',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Add a Program button
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add program action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9370DB), // Lavender color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    '+ Add a Program',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
      ],
    );
  }

  Widget buildCategorySection(String sectionTitle, String categoryKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children:
              List.generate(categoryItems[categoryKey]!.length, (itemIndex) {
            final itemLabel = categoryItems[categoryKey]![itemIndex];
            final isSelected =
                selectedIndicesByCategory[categoryKey] == itemIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    // Deselect if already selected
                    selectedIndicesByCategory[categoryKey] = null;
                  } else {
                    // Select the new item
                    selectedIndicesByCategory[categoryKey] = itemIndex;
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xff11404C)
                      : const Color(0xffBFD4D9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  itemLabel,
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
