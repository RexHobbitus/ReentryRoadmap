import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_date_picker_field.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../../service_locator/service_locator.dart';
import '../../onboarding_cubit.dart';
import '../../widgets/onboarding_title_widget.dart';

class ServiceProvidersAccessDates extends StatelessWidget {
  const ServiceProvidersAccessDates({super.key});

  OnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const OnboardingTitleWidget(
          title: "When did you access these providers?",
        ),
        for (var index = 0; index < cubit.selectedProviders.length; index++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                   CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(cubit.selectedProviders[index].icon!),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${cubit.selectedProviders[index].title}",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDatePickerField()
            ],
          )
      ],
    );
  }
}
