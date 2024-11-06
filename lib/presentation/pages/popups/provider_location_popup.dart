import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class ProviderLocationPopup extends StatefulWidget {
  const ProviderLocationPopup({
    super.key,
  });

  @override
  State<ProviderLocationPopup> createState() => _ProviderLocationPopupState();
}

class _ProviderLocationPopupState extends State<ProviderLocationPopup> {
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
              'Do you own or work at this provider location?',
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: context.colorScheme.tertiaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              width: deviceSize == DeviceSize.web ? 500 : double.infinity,
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Yes',
                        style: context.textTheme.bodyLarge,
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: context.colorScheme.tertiaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              width: deviceSize == DeviceSize.web ? 500 : double.infinity,
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'No',
                        style: context.textTheme.bodyLarge,
                      ))),
            )
          ],
        ),
      );
    });
  }
}
