import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/extensions/url_launcher_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/organization.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/service_card_category_chip.dart';

class SearchProviderTileMobile extends StatelessWidget {
  final Provider service;
  final List<OrganizationData> organizationList;

  const SearchProviderTileMobile({
    super.key,
    required this.service,
    required this.organizationList
  });

  @override
  Widget build(BuildContext context) {
    List features = [];
    for(Program ele in service.onboardingInfo?.programs??[]){
      features = [...features,ele.features??[]];
    }
    final chipList = service.getAllCategories();
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  CustomCachedImage(
                    imgUrl: service.onboardingInfo?.providerDetails?.images?.firstOrNull ?? kPlaceHolderImage,
                    height: 210,
                    width: double.infinity,
                  ),
                  Container(
                    height: 210,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black54,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            "${service.avgRating?.toDouble()} (${service.totalReviews ?? 0})",
                            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onPrimary),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    var list = organizationList
                        .where(
                          (element) => element.orgId == service.orgId,
                    )
                        .toList();

                    if (list.isEmpty) return const SizedBox.shrink();
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        service.onboardingInfo?.providerDetails?.orgWebsite?.launchUrlInBrowser();
                      },
                      child: Row(
                        children: [
                          Text(
                            list.first.orgName??"",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.secondaryContainer,
                              decorationColor: context.colorScheme.secondaryContainer,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                            color: context.colorScheme.secondaryContainer,
                          ),
                        ],
                      ),
                    );
                  }
                ),
                Text(
                  service.onboardingInfo?.providerDetails?.providerNameLocation ?? "",
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.location),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        service.completeAddress,
                        style: context.textTheme.labelMedium?.copyWith(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (var category in List.from(chipList).take(3).toList()) ServiceCardCategoryChip(title: category),
                    chipList.length > 3
                        ? Text(
                            "+ ${chipList.length - 3} More",
                            style: context.textTheme.bodyMedium?.copyWith(color: context.themeData.colorScheme.tertiary, fontSize: 10),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Eligibility Criteria",
                  style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                for (var info in service.getAllEligibilityCriteria().take(2).toList()) _FeatureOrEligibilityTile(title: info),
                const SizedBox(height: 20),
                Text(
                  "Features",
                  style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                for (var info in service.getAllFeatures().take(2).toList()) _FeatureOrEligibilityTile(title: info),
                const SizedBox(height: 10),

                Builder(
                  builder: (context) {
                    List eligibleTile = service.onboardingInfo?.programs?.where((element) => (element.eligibilityRatio??0)>=90,).toList()??[];

                    if(eligibleTile.isEmpty){
                      return const SizedBox.shrink();
                    }
                    bool showFullEligible = service.onboardingInfo?.programs?.where((element) => (element.eligibilityRatio??0)>=100,).toList().isNotEmpty??false;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colorScheme.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.starCheck),
                              const SizedBox(width: 5),
                              Text(
                                showFullEligible? "Eligible!":"Might be Eligible",
                                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSecondary),
                              ),
                            ],
                          ),
                          Text(
                            "for ${eligibleTile.length} Programs",
                            style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.primaryContainer),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProviderFeature extends StatelessWidget {
  final String title;

  const _ProviderFeature({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.secondaryContainer,
          radius: 4,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }
}

class _FeatureOrEligibilityTile extends StatelessWidget {
  final String title;

  const _FeatureOrEligibilityTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.labelMedium,
            ),
          )
        ],
      ),
    );
  }
}

class _ProgramCategoryTile extends StatelessWidget {
  final String label;

  const _ProgramCategoryTile({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorScheme.secondary,
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSecondary),
      ),
    );
  }
}
