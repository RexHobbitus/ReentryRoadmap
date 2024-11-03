import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class SearchFilterFields extends StatelessWidget {
  const SearchFilterFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Min. Distance",
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: ".mi",
                textAlign: TextAlign.end,
                inputBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.colorScheme.onSurface),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Max. Distance",
                style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: ".mi",
                textAlign: TextAlign.end,
                inputBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.colorScheme.onSurface),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
