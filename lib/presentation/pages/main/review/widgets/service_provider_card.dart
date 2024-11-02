import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';

import '../../../../../data/models/service_provider_accessed.dart';

/// This ServiceProviderCard must be changed to another one with all required data
class ServiceProviderCard extends StatelessWidget {
  final Function()? onTap;
  final ServiceProviderDataModel serviceProvider;

  const ServiceProviderCard({super.key, this.onTap, required this.serviceProvider});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: context.themeData.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _serviceImage(context: context),
              const SizedBox(height: 24),
              _serviceTitle(context: context, title: serviceProvider.name ?? "Service Provider"),
              const SizedBox(height: 5),
              _locationWidget(context: context, location: serviceProvider.address ?? "No address available"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceImage({required BuildContext context}) {
    return Stack(
      children: [
        CustomCachedImage(
          radius: 10,
          width: double.maxFinite,
          height: 210,
          imgUrl: serviceProvider.imgUrl ?? kPlaceHolderImage,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.0),
                ],
                stops: const [0.0068, 0.3274],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                    size: 10,
                  ),
                  const SizedBox(width: 5),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _locationWidget({required String location, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.location),
        const SizedBox(width: 5),
        Text(
          location,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.themeData.colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _serviceTitle({required String title, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(Assets.verified),
      ],
    );
  }

}