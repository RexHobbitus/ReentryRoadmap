import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/onboarding_provider.dart';

import 'package:provider/provider.dart';

final List<Map<String, dynamic>> sections = [
  {
    'name': 'Personal Details',
    'questions': [
      {'id': 'p1', 'type': 'text', 'question': 'What is your full name?'},
      {
        'id': 'p2',
        'type': 'date',
        'question': 'What is your date of birth',
      },
      {
        'id': 'p3',
        'type': 'radio',
        'question': 'Which of these best describe your ethnicity?',
        'options': [
          'Hispanic or Latino',
          'American Indian or Alaska Native',
          'Asian',
          'White',
          'Black or African American',
          'Native Hawaiian or Other Pacific Islander'
        ]
      },
      {
        'id': 'p4',
        'type': 'radio',
        'question': 'What is your gender?',
        'options': ['Male', 'Female', 'Other', 'Nonbinary']
      },
      {
        'id': 'p5',
        'type': 'radio',
        'question': 'Are you a veteran?',
        'options': ['Yes', 'No']
      },
      {
        'id': 'p6',
        'type': 'dropdown-with-multi-text',
        'question': 'Please provide your location',
        'options': [
          'New York',
          'Washington',
          'Seatle',
          'Las Vegas',
          'Miami',
          'Florida'
        ],
        'textFieldCount': 2,
        'textFieldLabels': [
          'Street Address (Optional)',
          'City',
        ],
      },
      {'id': 'p7', 'type': 'text', 'question': 'What is your Phone Number?'},
    ]
  },
  {
    'name': 'Incarceration Details',
    'questions': [
      {
        'id': 'i1',
        'type': 'dropdown-dynamic',
        'question': 'Please provide your ID number',
        'options': [
          'Federal Prison ID',
          'CDCR Number',
          'Jail ID',
          'Other Institutional ID',
        ],
        'dynamicFields': {
          'Federal Prison ID': 1,
          'Other Institutional ID': 2,
        },
        'textFieldLabels': [
          'Enter ID Type',
          'ID Number',
        ],
      },
      {
        'id': 'i2',
        'type': 'radio',
        'question': 'How many times have you been incarcerated?',
        'options': ['1-3', '4-6', '7+']
      },
      {
        'id': 'i3',
        'type': 'radio',
        'question': 'How would you describe your incarceration history?',
        'options': [
          'In and Out my entire life',
          'One long time',
          'A few times',
        ]
      },
      {
        'id': 'i4',
        'type': 'checkbox',
        'question': 'What type of offence were you incarcerated for? ',
        'options': ['Violent', 'Non-violent', 'Misdemeanor', 'Sexual']
      },
      {
        'id': 'i5',
        'type': 'radio',
        'question': 'What was the length of your longest incarceration?',
        'options': [
          '0-3 years',
          '3-5 years',
          '5-10 years',
          '10-15 years',
          '15+ years'
        ]
      },
      {
        'id': 'i6',
        'type': 'radio',
        'question': 'What was the length of your latest incarceration?',
        'options': [
          '0-3 years',
          '3-5 years',
          '5-10 years',
          '10-15 years',
          '15+ years'
        ]
      },
      {
        'id': 'i7',
        'type': 'date', // Updated type to 'date'
        'question': 'When were you first incarcerated?',
      },
      {
        'id': 'i8',
        'type': 'date', // Updated type to 'date'
        'question': 'What was your latest release date?',
      },
      {
        'id': 'i9',
        'type': 'radio',
        'question': 'Where did you serve your most recent term?',
        'options': ['County Jail', 'State Prison', 'Federal Prison']
      },
      {
        'id': 'i10',
        'type': 'checkbox',
        'question': 'Where did you serve your most recent term?',
        'options': [
          'Alternatives to Violence Project (AVP)',
          'Arts in Corrections',
          'BRAG (Brothers Reaching Across the Gate)',
          'Criminals and Gang Members Anonymous',
          'Youth Offender Program (YOP)',
          'Parenting and Family Reunification Programs',
          'Getting Out by Going In (GOGI)',
          'Toastmasters Gavel Club',
          'Restorative Justice Program'
        ]
      },
    ]
  },
  {
    'name': 'Your current needs',
    'questions': [
      {
        'id': 'n1',
        'type': 'checkbox-limit',
        'question': 'What are your top priorities for the next few months? ',
        'options': [
          'Education',
          'Employment',
          'Housing',
          'Life Skills',
          'Finance',
          'Legal',
          'Transportation',
          'Community',
          'Health'
        ],
        'limit': 3,
      },
      {
        'id': 'n2',
        'type': 'radio',
        'question': 'Do you prefer large or small service providers?',
        'options': ['Small (0-50)', 'Medium (50-250)', 'Large (250+)']
      },
      {
        'id': 'n3',
        'type': 'radio',
        'question': 'What is your current housing status?',
        'options': [
          'Housing Insecure',
          'Transitional Housing',
          'Living with family/friends',
          'Renting or owning a home'
        ]
      },
      {
        'id': 'n4',
        'type': 'radio',
        'question': 'What is your highest level of education?',
        'options': [
          'Working to GED',
          'High School Diploma or GED',
          'Some College',
          'Associated Degree',
          'Bachelor’s Graduate',
          'Graduate School and Beyond'
        ]
      },
      {
        'id': 'n5',
        'type': 'chekbox',
        'question': 'Do you have any trade certifications?',
        'options': [
          'None',
          'OSHA',
          'Forklift Operator',
          'CDL',
          'HVAC',
          'Building Maintenance',
          'Plumbing',
          'ServSafe',
          'CNA'
        ]
      },
      {
        'id': 'n6',
        'type': 'chekbox-subtext',
        'question': 'What kind of skills would you like to improve on?',
        'options': [
          {'text': 'Digital Skills', 'subtext': 'Computer literacy, IT, etc'},
          {
            'text': 'Financial Skills',
            'subtext': 'Budgeting, managing money, etc'
          },
          {
            'text': 'Technical or trade skills',
            'subtext': 'Plumbing, Welding, etc'
          },
          {
            'text': 'Personal Development',
            'subtext': 'Emotional intelligence, self-care, etc'
          },
          {
            'text': 'Professional skills',
            'subtext': 'Resume writing, communication'
          },
          {'text': 'Other/ None', 'subtext': ''}
        ]
      },
      {
        'id': 'n7',
        'type': 'radio',
        'question': 'Are you currently employed?',
        'options': [
          'Yes, employed full-time',
          'Yes, employed part-time',
          'No, not employed'
        ]
      },
      {
        'id': 'n8',
        'type': 'chekbox-subtext',
        'question': 'What kind of skills would you like to improve on?',
        'options': [
          {
            'text': 'Service',
            'subtext': 'Restaurants, healthcare, retail shops, etc'
          },
          {
            'text': 'Administrative/Office Support',
            'subtext': 'Clerical work, data entry, reception, office management'
          },
          {
            'text': 'Labor/ Manufacturing',
            'subtext': 'Factory work, construction, warehousing, etc'
          },
          {
            'text': 'Sales/Marketing',
            'subtext': 'Sales roles, marketing positions, business development'
          },
          {
            'text': 'Skilled Trades',
            'subtext': 'Electrical work, plumbing, carpentry, etc'
          },
          {
            'text': 'Information Technology (IT)',
            'subtext': 'IT support, software development, technical services'
          }
        ]
      },
      {
        'id': 'n9',
        'type': 'radio',
        'question': 'What is your current salary level',
        'options': [
          'Working for free',
          '\'Less than \$25,000',
          '\$25,000 - \$50,000',
          '\$50,000 - \$100,000',
          '\$100,000 +'
        ]
      },
      {
        'id': 'n10',
        'type': 'chekbox-subtext',
        'question': 'What kind of career would you like to pursue?',
        'options': [
          {
            'text': 'Service',
            'subtext': 'Restaurants, healthcare, retail shops, etc'
          },
          {
            'text': 'Administrative/Office Support',
            'subtext': 'Clerical work, data entry, reception, office management'
          },
          {
            'text': 'Labor/ Manufacturing',
            'subtext': 'Factory work, construction, warehousing, etc'
          },
          {
            'text': 'Sales/Marketing',
            'subtext': 'Sales roles, marketing positions, business development'
          },
          {
            'text': 'Skilled Trades',
            'subtext': 'Electrical work, plumbing, carpentry, etc'
          },
          {
            'text': 'Information Technology (IT)',
            'subtext': 'IT support, software development, technical services'
          }
        ]
      },
      {
        'id': 'n11',
        'type': 'radio',
        'question': 'What is your expected salary level',
        'options': [
          '\'Less than \$25,000',
          '\$25,000 - \$50,000',
          '\$50,000 - \$100,000',
          '\$100,000 +'
        ]
      },
      {
        'id': 'n12',
        'type': 'text',
        'question':
            'Are you looking for any other resources we haven’t mentioned?'
      },
    ]
  },
  {
    'name': 'Your Service Provider',
    'questions': [
      {
        'id': 'sp1',
        'type': 'text',
        'question': 'What Service Providers have you accessed so far?'
      },
      {
        'id': 'sp2',
        'type': 'dateRange',
        'question': 'When did you access these providers?',
      },
    ]
  },
];

class QuestionFormScreen extends StatefulWidget {
  final int sectionIndex;

  QuestionFormScreen({required this.sectionIndex});

  @override
  _QuestionFormScreenState createState() => _QuestionFormScreenState();
}

class _QuestionFormScreenState extends State<QuestionFormScreen> {
  final Map<String, dynamic> answers = {};
  DateTime? selectedDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentProvider>(context);
    final section = sections[widget.sectionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('${section['name']} Section')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: section['questions'].map<Widget>((question) {
          switch (question['type']) {
            case 'text':
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  decoration: InputDecoration(labelText: question['question']),
                  onChanged: (val) {
                    setState(() {
                      answers[question['id']] = val;
                    });
                  },
                ),
              );
            case 'date':
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question['question']),
                    SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                            answers[question['id']] = "${date.toLocal()}"
                                .split(' ')[0]; // Store date as string
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(selectedDate == null
                            ? 'Select Date'
                            : "${selectedDate!.toLocal()}".split(' ')[0]),
                      ),
                    ),
                  ],
                ),
              );
            case 'dateRange':
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question['question']),
                    SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedStartDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            selectedStartDate = date;
                            answers['${question['id']}_start'] =
                                "${date.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(selectedStartDate == null
                            ? 'Select Start Date'
                            : "${selectedStartDate!.toLocal()}".split(' ')[0]),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedEndDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            selectedEndDate = date;
                            answers['${question['id']}_end'] =
                                "${date.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(selectedEndDate == null
                            ? 'Select End Date'
                            : "${selectedEndDate!.toLocal()}".split(' ')[0]),
                      ),
                    ),
                  ],
                ),
              );

            case 'checkbox-limit':
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question['question'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...question['options'].map<Widget>((option) {
                    return CheckboxListTile(
                      title: Text(option),
                      value: (answers[question['id']] as List?)
                              ?.contains(option) ??
                          false,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            if (answers[question['id']] == null) {
                              answers[question['id']] = [];
                            }
                            if ((answers[question['id']] as List).length <
                                question['limit']) {
                              (answers[question['id']] as List).add(option);
                            }
                          } else {
                            (answers[question['id']] as List).remove(option);
                          }
                        });
                      },
                    );
                  }).toList(),
                  Text(
                    'You can select a maximum of ${question['limit']} options.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              );

            case 'dropdown-dynamic':
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: question['question']),
                      value: answers[question['id']],
                      items: question['options']
                          .map<DropdownMenuItem<String>>((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          answers[question['id']] = val;
                          // Clear previous dynamic fields
                          // Set the number of dynamic fields based on the selected option
                          //this is optional so you can either store or reject it
                          if (val != null) {
                            answers['dynamicFields'] =
                                question['dynamicFields'][val];
                          }
                        });
                      },
                    ),
                    // Dynamically show text fields based on dropdown selection
                    if (answers['dynamicFields'] != null)
                      Column(
                        children:
                            List.generate(answers['dynamicFields'], (index) {
                          String label = question['textFieldLabels'][
                              index]; 
                              // Get the label for the current text field insteaf of declare seperate fields

                          return TextField(
                            decoration: InputDecoration(labelText: label),
                            onChanged: (val) {
                              setState(() {
                                answers[label] = val;
                              });
                            },
                          );
                        }),
                      ),
                  ],
                ),
              );

            case 'dropdown-with-multi-text':
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown Field
                  DropdownButtonFormField<String>(
                    decoration:
                        InputDecoration(labelText: question['question']),
                    value: answers[question['id']],
                    items: question['options']
                        .map<DropdownMenuItem<String>>((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        answers[question['id']] = val;
                      });
                    },
                  ),
                  // for Multiple Text Fields
                  SizedBox(height: 16.0),
                  ...List.generate(question['textFieldCount'], (index) {
                    String label = question['textFieldLabels']
                        [index]; 
                    return TextField(
                      decoration: InputDecoration(labelText: label),
                      onChanged: (val) {
                        setState(() {
                          answers[''] = val;
                        });
                      },
                    );
                  }),
                ],
              );
            case 'radio':
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question['question'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...question['options'].map<Widget>((option) {
                    return RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: answers[question['id']],
                      onChanged: (val) {
                        setState(() {
                          answers[question['id']] = val;
                        });
                      },
                    );
                  }).toList(),
                ],
              );
            case 'chekbox-subtext':
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question['question']),
                  ...question['options'].map<Widget>((option) {
                    return CheckboxListTile(
                      title: Text(option['text']),
                      subtitle: Text(option['subtext'] ?? ''),
                      value: (answers[question['id']] as List?)
                              ?.contains(option['text']) ??
                          false,
                      onChanged: (val) {
                        setState(() {
                          final selectedAnswers =
                              (answers[question['id']] ?? []) as List;

                          // Check if a limit is specified and apply it
                          final limit = question['limit'] ?? double.infinity;

                          if (val == true && selectedAnswers.length < limit) {
                            selectedAnswers.add(option['text']);
                          } else if (val == false) {
                            selectedAnswers.remove(option['text']);
                          }

                          // Update the answers int the map
                          answers[question['id']] = selectedAnswers;
                        });
                      },
                    );
                  }).toList(),
                  if ((answers[question['id']] as List?)?.length ==
                      question['limit'])
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'You can select only a maximum of ${question['limit']} options.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              );

            case 'checkbox':
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question['question'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...question['options'].map<Widget>((option) {
                    return CheckboxListTile(
                      title: Text(option),
                      value: (answers[question['id']] as List?)
                              ?.contains(option) ??
                          false,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            if (answers[question['id']] == null)
                              answers[question['id']] = [];
                            (answers[question['id']] as List).add(option);
                          } else {
                            (answers[question['id']] as List).remove(option);
                          }
                        });
                      },
                    );
                  }).toList(),
                ],
              );

            default:
              return SizedBox.shrink();
          }
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          provider.saveSectionAnswers(section['name'], answers);

          if (widget.sectionIndex < sections.length - 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionFormScreen(sectionIndex: widget.sectionIndex + 1),
              ),
            );
          } else {
            await provider.submitAllAnswers();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SummaryScreen()),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Summary')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: provider.allAnswers.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${entry.key} Section',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...entry.value.entries.map((qEntry) {
                return ListTile(
                  title: Text(qEntry.key),
                  subtitle: Text('Answer: ${qEntry.value}'),
                );
              }).toList(),
              SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
