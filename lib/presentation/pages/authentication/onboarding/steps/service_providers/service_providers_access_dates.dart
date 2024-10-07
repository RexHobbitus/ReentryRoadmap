import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_date_picker_field.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class ServiceProvidersAccessDates extends StatelessWidget {
  const ServiceProvidersAccessDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "When did you access these providers?",
          style: AppStyle.onboardingTitle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        for (var index = 0; index < 3; index++)
          Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(Assets.serviceProviderOpenDoor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "OpenGate Foundation",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDatePickerField(controller: TextEditingController())
            ],
          )
      ],
    );
  }
}
