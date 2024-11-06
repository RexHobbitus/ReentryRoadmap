import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class SearchFilterFields extends StatelessWidget {
  final SearchCubit cubit;
final bool fromBottom;
final TextEditingController? maxDistance;
final TextEditingController? miniDistance;
  const SearchFilterFields({super.key, required this.cubit, required this.fromBottom, this.maxDistance, this.miniDistance});

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
                controller: miniDistance??cubit.minDistanceController,
                keyboard: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChange: fromBottom?null: (p0) => cubit.handleMileFilter(),
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
                controller: maxDistance??cubit.maxDistanceController,
                keyboard: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.end,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChange: fromBottom?null:  (p0) => cubit.handleMileFilter(),
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
