import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/cubits/my_services_tile_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';

class ServiceImageView extends StatelessWidget {
  const ServiceImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final tileCubit=context.read<MyServicesTileCubit>();
    return Stack(
      children: [
        CustomCachedImage(
          radius: 10,
          width: double.maxFinite,
          height:  210,
          imgUrl:"https://plus.unsplash.com/premium_photo-1673292293042-cafd9c8a3ab3?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
          //tileCubit.myService.provider?.onboardingInfo?.providerDetails?.images?[0],
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter, // Bottom
                end: Alignment.topCenter, // Top
                colors: [
                  Colors.black.withOpacity(0.8),
                  // Start with black at the bottom
                  Colors.black.withOpacity(0.0),
                  // Gradually become transparent at the top
                ],
                stops: const [
                  0.0068,
                  0.3274
                ], // Corresponding to 0.68% and 32.74%
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: context.themeData.colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: context.themeData.colorScheme.tertiaryContainer,
                    size: 14,
                  ),
                  5.horizontalSpace,
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: tileCubit.myService.provider?.avgRating.toString() ?? "0",
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: context.colorScheme.onPrimary),),
                      TextSpan(text:  " (${tileCubit.myService.provider!.totalReviews})",
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: context.colorScheme.onPrimary),),

                    ]),

                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
