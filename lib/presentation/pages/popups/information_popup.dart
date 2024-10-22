import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class InformationPopup extends StatelessWidget {
  final String title;
  final String subTitle;

  const InformationPopup(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
        return SizedBox(
          width: deviceSize == DeviceSize.web ? 500 : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                    alignment: Alignment.centerRight, child: Icon(Icons.close)),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                title,
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                subTitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    );
  }
}
