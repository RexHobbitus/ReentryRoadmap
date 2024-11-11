import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/domain/entities/program_category.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/cubits/my_services_tile_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/service_card_category_chip.dart';

class ProgramView extends StatelessWidget {
  const ProgramView({super.key});

  final int maxLimit = 5;

  @override
  Widget build(BuildContext context) {
    final tileCubit = context.read<MyServicesTileCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context
                  .read<MyServicesTileCubit>()
                  .myService
                  .provider
                  ?.onboardingInfo!
                  .programs?[0]
                  .name ??
              "N/A",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        10.verticalSpace,
        Wrap(
          //  mainAxisSize: MainAxisSize.min,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (ProgramCategory category in List.from(
                    tileCubit.myService.provider?.onboardingInfo!.programs![0].programCategories ?? [])
                .take(maxLimit)
                .toList())
              ServiceCardCategoryChip(
                title: category.title!,
              ),
            tileCubit.myService.provider!.onboardingInfo!.programs![0]
                        .programCategories!.length >
                    maxLimit
                ? Text(
                    "+ ${tileCubit.myService.provider!.getAllCategories().length - maxLimit} More",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.tertiary,
                        fontSize: Responsive.getResponsiveValueDouble(
                            context, 10, 12, 12)),
                  )
                : const SizedBox.shrink(),
          ],
        )
      ],
    );
  }
}
