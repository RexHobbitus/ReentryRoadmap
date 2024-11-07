import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/cubits/my_services_tile_cubit.dart';

class ServiceUpdatesView extends StatelessWidget {
  const ServiceUpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    final tileCubit=context.read<MyServicesTileCubit>();
    return Column(children: List.generate(tileCubit.myService.statusUpdates!.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
             CircleAvatar(
              radius: 8,
              backgroundColor: context.colorScheme.primary,
              child: Icon(
                Icons.check,
                size: 10,
                color: context.colorScheme.onPrimary,
              ),
            ),
            10.horizontalSpace,
            Flexible(
              child: Text(
                tileCubit.myService.statusUpdates![index],
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: Responsive.getResponsiveValueDouble(
                      context, 15, 15, 16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      );
    },),);
  }
}
