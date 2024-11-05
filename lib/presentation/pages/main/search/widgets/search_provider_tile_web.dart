import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/service_card_category_chip.dart';

class SearchProviderTileWeb extends StatelessWidget {
  final Provider service;

  const SearchProviderTileWeb({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final chipList = service.getAllCategories();
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          CustomCachedImage(
                            imgUrl: service.onboardingInfo?.providerDetails?.images?.firstOrNull ?? kPlaceHolderImage,
                            height: 260,
                            width: 230,
                          ),
                          Container(
                            height: 260,
                            width: 230,
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
                    const SizedBox(width: 22),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Opengate Foundation",
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
                          Text(
                            service.onboardingInfo?.providerDetails?.providerNameLocation ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.location),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  service.completeAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.labelMedium?.copyWith(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
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
                          const _ProviderFeature(title: "Women Only"),
                          const SizedBox(height: 4),
                          const _ProviderFeature(title: "Formerly Incarcerated Leadership"),
                          const SizedBox(height: 10),
                          Text(
                            "Our Take",
                            style: context.textTheme.labelMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout...",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.secondaryContainer),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (constraints.maxWidth > 800 && (service.onboardingInfo?.programs ?? []).isNotEmpty) ...[
              _ManagementProgram(programs: service.onboardingInfo?.programs ?? []),
            ],
          ],
        ),
      );
    });
  }
}

class _ManagementProgram extends StatefulWidget {
  final List<Program> programs;

  const _ManagementProgram({super.key, required this.programs});

  @override
  State<_ManagementProgram> createState() => _ManagementProgramState();
}

class _ManagementProgramState extends State<_ManagementProgram> {
  ValueNotifier<int> currentProgram = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentProgram,
        builder: (context, value, child) {
          final program = widget.programs[currentProgram.value];
          final programCategoryList = program.programCategories?.map((e) => e.title ?? "").toList() ?? [];
          return Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(color: context.colorScheme.tertiaryContainer),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program.name ?? "",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if ((program.programCategories ?? []).isNotEmpty) ...[
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for (var category in List.from(programCategoryList).take(1).toList()) _ProgramCategoryTile(label: category),
                            if ((program.programCategories ?? []).length > 1) ...[
                              Text(
                                "+ ${(program.programCategories ?? []).length - 1} More",
                                style: context.textTheme.bodyMedium?.copyWith(color: context.themeData.colorScheme.secondary, fontSize: 10),
                              ),
                            ]
                          ],
                        ),
                      ],
                      const SizedBox(height: 10),
                      if (program.eligibilityCriteria?.isNotEmpty ?? false) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Eligibility Criteria",
                              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            for (var info in program.eligibilityCriteria?.take(2).toList() ?? []) _FeatureOrEligibilityTile(title: info),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (program.features?.isNotEmpty ?? false) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Features",
                              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            for (var info in program.features?.take(2).toList() ?? []) _FeatureOrEligibilityTile(title: info),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colorScheme.primary,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.starCheck),
                            const SizedBox(width: 5),
                            Text(
                              "Eligible!",
                              style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (widget.programs.length > 1) ...[
                  Divider(color: context.colorScheme.onSecondary, height: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: (currentProgram.value > 0)
                            ? () {
                                currentProgram.value = --currentProgram.value;
                              }
                            : null,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 14,
                        ),
                      ),
                      ...List.generate(
                        widget.programs.length,
                        (index) {
                          if (index == currentProgram.value) {
                            return CircleAvatar(backgroundColor: context.colorScheme.secondary, radius: 16, child: Text(" ${index + 1} "));
                          }
                          return Text(" ${index + 1} ");
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (currentProgram.value < (widget.programs.length - 1))
                            ? () {
                                currentProgram.value = ++currentProgram.value;
                              }
                            : null,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ]
              ],
            ),
          );
        });
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
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium,
          ),
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
