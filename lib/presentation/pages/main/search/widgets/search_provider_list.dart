import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_mobile_filter_categories.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_provider_tile_mobile.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_provider_tile_web.dart';

class SearchProviderList extends StatelessWidget {
  final SearchCubit cubit;
  final bool isBigScreen;

  const SearchProviderList({
    super.key,
    required this.cubit,
    required this.isBigScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        if (isBigScreen) ...[
          SearchTopResultWeb(cubit: cubit),
        ] else ...[
          SearchTopResultMobile(cubit: cubit),
        ],
        const SizedBox(height: 20),
        if (isBigScreen) ...[
          const LearnMoreWeb(),
        ] else ...[
          const LearnMoreMobile(),
        ],
        const SizedBox(height: 30),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            if (isBigScreen) {
              return const SearchProviderTileWeb();
            }
            return const SearchProviderTileMobile();
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 14,
            ),
            ...List.generate(
              5,
              (index) {
                if (index == 2) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.surfaceContainer,
                        border: Border.all(color: context.colorScheme.tertiaryContainer),
                      ),
                      child: Text(" ${index + 1} "));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(" ${index + 1} "),
                );
              },
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 30),
        if (isBigScreen) ...[
          const _AddProviderWeb(),
        ] else ...[
          const _AddProviderMobile(),
        ],
        const SizedBox(height: 30),
      ],
    );
  }
}

class _AddProviderWeb extends StatelessWidget {
  const _AddProviderWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.surfaceContainer,
          border: Border.all(color: context.colorScheme.tertiaryContainer, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Can’t find the provider you want?",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Add your provider to Dignifi",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 15,
                    color: context.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: context.colorScheme.onSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Add a provider",
                    style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSecondary),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AddProviderMobile extends StatelessWidget {
  const _AddProviderMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.surfaceContainer,
          border: Border.all(color: context.colorScheme.tertiaryContainer, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Can’t find the provider you want?",
            style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "Add your provider to Dignifi",
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: context.colorScheme.onSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Add a provider",
                    style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSecondary),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchTopResultWeb extends StatelessWidget {
  final SearchCubit cubit;

  const SearchTopResultWeb({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Top Results for ‘First Steps’",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Show eligible providers only",
              style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: true,
                onChanged: (value) {},
                activeColor: context.colorScheme.secondary,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SearchTopResultMobile extends StatelessWidget {
  final SearchCubit cubit;

  const SearchTopResultMobile({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top Results for ‘First Steps’",
              style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Show eligible providers only",
                  style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, color: context.colorScheme.onSurface.withOpacity(0.5)),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: context.colorScheme.secondary,
                  ),
                )
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {
            cubit.navigator.navigator.showBottomSheet(context, const SearchMobileFilterCategories());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                Assets.filter,
                height: 20,
              ),
              const SizedBox(height: 8),
              Text(
                "Filter",
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LearnMoreWeb extends StatelessWidget {
  const LearnMoreWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 23),
      decoration: BoxDecoration(color: context.colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: const [
                      TextSpan(text: "Provide a "),
                      TextSpan(text: "Check In", style: TextStyle(decoration: TextDecoration.underline)),
                      TextSpan(text: " to get the best matches!"),
                    ],
                    style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.onSecondary),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Update us on your reentry journey so we can find you the best services",
                  style: context.textTheme.labelLarge?.copyWith(fontSize: 15, color: context.colorScheme.tertiaryContainer),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Learn More",
                style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSecondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LearnMoreMobile extends StatelessWidget {
  const LearnMoreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 23),
      decoration: BoxDecoration(color: context.colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: const [
                TextSpan(text: "Provide a "),
                TextSpan(text: "Check In", style: TextStyle(decoration: TextDecoration.underline)),
                TextSpan(text: " to get the best matches!"),
              ],
              style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.onSecondary, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Update us on your reentry journey so we can find you the best services",
            style: context.textTheme.labelLarge?.copyWith(fontSize: 15, color: context.colorScheme.tertiaryContainer),
          ),
          const SizedBox(height: 10),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Learn More",
                style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSecondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
