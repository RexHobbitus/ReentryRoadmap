import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';

import 'service_card_category_chip.dart';

class ProviderServiceCard extends StatelessWidget {
  final Function(Provider)? onTap;
  final Provider provider;
  final bool isOnboardedMode;

  const ProviderServiceCard({
    super.key,
    this.onTap,
    required this.provider,
    this.isOnboardedMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onTap?.call(provider);
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
            maxHeight: 600
          ),
          padding: const EdgeInsets.only(left: 20,right: 20, top: 30,bottom: 20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceDim,
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
                  context: context, location: provider.completeAddress),
              const SizedBox(
                height: 15,
              ),
              _serviceCategories(context: context),
              const SizedBox(
                height: 15,
              ),
              _subSection(
                  context: context,
                  title: "Features",
                  data: provider.getAllFeatures().take(2).toList()),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height:20,
                    ),
                    // _subSection(
                    //     context: context,
                    //     title: "Eligibility Criteria",
                    //     data: provider.getAllEligibilityCriteria().take(2).toList()),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                
                    isOnboardedMode?Container(
                      width: double.maxFinite,
                      padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
                      decoration: BoxDecoration(
                          color: context.themeData.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.starCheck),
                          const SizedBox(width: 10,),
                          Text(
                            "Eligible!",
                            style: context.textTheme.bodyLarge?.copyWith(
                                color: context.themeData.colorScheme.onPrimary),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            "for 4 programs",
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: context.themeData.colorScheme.onPrimary
                                    .withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ):const SizedBox.shrink(),
                  ],
                ),
              )
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
        SvgPicture.asset(
          Assets.location,
          width: 8,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            location,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.secondaryFixed,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _serviceTitle({required String title, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              overflow: TextOverflow.ellipsis
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(
          Assets.verified,
          width: 12,
        ),
      ],
    );
  }

  Widget _serviceCategories({required BuildContext context}) {
    List<String> categories = provider.getAllCategories();
    int maxLimit = 2;
    return Wrap(
      //  mainAxisSize: MainAxisSize.min,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var category in List.from(categories).take(maxLimit).toList())
          ServiceCardCategoryChip(
            title: category,
          ),
        categories.length > maxLimit
            ? Text(
                "+ ${categories.length - maxLimit} More",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.themeData.colorScheme.tertiary,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _subSection(
      {required BuildContext context,
      required String title,
      required List<String> data}) {
    return data.isEmpty
        ? const SizedBox.shrink()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              for (var info in data)
                _featureOrEligibilityTile(context: context, title: info)
            ],
          );
  }

  Widget _featureOrEligibilityTile(
      {required BuildContext context, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: context.colorScheme.primary,
            child: Icon(
              Icons.check,
              size: 10,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                overflow: TextOverflow.ellipsis
              ),
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
