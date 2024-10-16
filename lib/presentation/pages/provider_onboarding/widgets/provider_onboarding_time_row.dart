import 'package:flutter/material.dart';

class ProviderOnboardingTimeRow extends StatelessWidget {
  final String day;
  final int index;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final double weekFontSize;
  final Future<void> Function(BuildContext context, bool isStart, int dayIndex)
      onSelectTime;

  const ProviderOnboardingTimeRow({
    Key? key,
    required this.day,
    required this.index,
    required this.startTime,
    required this.endTime,
    required this.weekFontSize,
    required this.onSelectTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Day Container
        Container(
          height: 80,
          width: 192,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(fontSize: weekFontSize, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 16),

        // Start Time Picker Button
        GestureDetector(
          onTap: () => onSelectTime(context, true, index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              startTime?.format(context) ??
                  '--', // Show '--' if time is not selected
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(width: 8),

        // "to" Text
        Text(
          'to',
          style: TextStyle(fontSize: 16),
        ),

        SizedBox(width: 8),

        // End Time Picker Button
        GestureDetector(
          onTap: () => onSelectTime(context, false, index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              endTime?.format(context) ??
                  '--', // Show '--' if time is not selected
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
