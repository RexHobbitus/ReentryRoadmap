import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';

import 'service_card_category_chip.dart';

class ServiceCard extends StatelessWidget {
  final Function(Provider)? onTap;
  final Provider provider;

  const ServiceCard({super.key, this.onTap, required this.provider});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          onTap?.call(provider);
        },
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
              const SizedBox(
                height: 24,
              ),
              _serviceTitle(
                  context: context,
                  title:
                      "${provider.onboardingInfo?.providerDetails?.providerNameLocation}"),
              const SizedBox(
                height: 5,
              ),
              _locationWidget(
                  context: context,
                  location: provider.completeAddress),
              const SizedBox(
                height: 20,
              ),
              _serviceCategories(context: context),
              const SizedBox(
                height: 20,
              ),
              _serviceTitles(context: context),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Divider(
                  thickness: 1,
                  height: 0,
                ),
              ),
              Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
                decoration: BoxDecoration(
                    color: context.themeData.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "70% Match",
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: context.themeData.colorScheme.onPrimary),
                    ),
                    Text(
                      "You might be eligible",
                      style: context.textTheme.bodySmall?.copyWith(
                          color: context.themeData.colorScheme.onPrimary
                              .withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
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
          imgUrl: provider.onboardingInfo!.providerDetails!.images!.isEmpty
              ? kPlaceHolderImage
              : provider.onboardingInfo!.providerDetails!.images!.first,
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
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${provider.avgRating} (${provider.totalReviews})",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _locationWidget(
      {required String location, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.location),
        const SizedBox(
          width: 5,
        ),
        Text(
          location,
          style: context.textTheme.bodySmall
              ?.copyWith(color: context.themeData.colorScheme.secondary),
        )
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

  Widget _serviceCategories({required BuildContext context}) {
    List<String> categories=provider.onboardingInfo?.generalService?.serviceCategories?.map((category)
    => category.title.toString()
    ).toList()??[];
    return Wrap(
      //  mainAxisSize: MainAxisSize.min,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for(var category in  List.from(categories).take(3).toList())
        ServiceCardCategoryChip(
          title: category,
        ),
        categories.length>3?
        Text(
          "+ 3 More",
          style: context.textTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.tertiary, fontSize: 10),
        ):SizedBox(),
      ],
    );
  }

  Widget _serviceTitles({required BuildContext context}) {
    return Column(
      children: [
        for (var index = 0; index < provider.onboardingInfo!.programs!.length; index++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Assets.leaf),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${provider.onboardingInfo!.programs![index].name}",
                  style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.themeData.colorScheme.onTertiaryContainer),
                )
              ],
            ),
          )
      ],
    );
  }
}
