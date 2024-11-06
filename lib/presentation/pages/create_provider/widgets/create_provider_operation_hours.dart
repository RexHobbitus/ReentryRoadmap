// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/date_time_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/extensions/time_of_day_extension.dart';
import 'package:reentry_roadmap/presentation/pages/create_provider/create_provider_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class CreateProviderOperatingHours extends StatefulWidget {
  @override
  _CreateProviderOperatingHoursState createState() =>
      _CreateProviderOperatingHoursState();
}

class _CreateProviderOperatingHoursState
    extends State<CreateProviderOperatingHours> {
  CreateProviderCubit get cubit => getIt();

  Future<void> _selectTime(
      BuildContext context, bool isStart, int dayIndex) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          cubit.operatingHours[dayIndex].startTime = picked.toDateTime();
        } else {
          cubit.operatingHours[dayIndex].endTime = picked.toDateTime();
        }
        cubit.notifyTextFieldUpdates();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildDayRow(index),
                  );
                }),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildDayRow(index + 4),
                  );
                }),
              ),
            ],
          );
        } else {
          return Column(
            children: List.generate(7, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildDayRow(index),
              );
            }),
          );
        }
      },
    );
  }

  Widget _buildDayRow(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              cubit.operatingHours[index].day ?? "",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(context, true, index),
            child: Container(
              width: 110,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: context.colorScheme.tertiaryContainer),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  cubit.operatingHours[index].startTime?.toTimeAMPM() ??
                      "__:__ __",
                  // Show '--' if time is not selected
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        Text(
          'to',
          style: TextStyle(
              fontSize: 10, color: context.colorScheme.tertiaryContainer),
        ),
        GestureDetector(
          onTap: () => _selectTime(context, false, index),
          child: Container(
            width: 110,
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.tertiaryContainer),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                cubit.operatingHours[index].endTime?.toTimeAMPM() ??
                    "__:__ __", // Show '--' if time is not selected
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
