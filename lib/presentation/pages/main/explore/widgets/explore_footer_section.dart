import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/extensions/url_launcher_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/featured_provider_our_take.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreFooterSection extends StatefulWidget {
  final ExploreCubit cubit;

  const ExploreFooterSection({
    super.key,
    required this.cubit,
  });

  @override
  State<ExploreFooterSection> createState() => _ExploreFooterSectionState();
}

class _ExploreFooterSectionState extends State<ExploreFooterSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: context.themeData.cardColor,
      child: Column(
        children: [
          _companyProfileSection(context: context),

          const SizedBox(
            height: 30,
          ),
          _disclaimerWidget(context: context),
          const SizedBox(
            height: 30,
          ),
          _ceoInformation(context: context),
        ],
      ),
    );
  }

  int featuredIndex = 0;

  _companyProfileSection({required BuildContext context}) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      bloc: widget.cubit,
      builder: (context, state) {
        FeaturedProviderOurTake featuredProviderOurTake = state.loading
            ? FeaturedProviderOurTake.shimmer()
            : state.featuredProvidersOurTake[featuredIndex];
        return (!state.loading && state.featuredProvidersOurTake.isEmpty)
            ? const SizedBox.shrink()
            : Skeletonizer(
                enabled: state.loadingOurTakes,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: context.colorScheme.secondary,
                          radius: 35,
                          backgroundImage: CachedNetworkImageProvider("${featuredProviderOurTake.profilePic}",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Our Rating",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colorScheme.secondaryFixed),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: context.colorScheme.secondary,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${featuredProviderOurTake.rating}",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colorScheme.secondaryFixed),
                                ),
                              ],
                            ),
                            Text(
                              "${featuredProviderOurTake.name}",
                              style: context.textTheme.titleMedium,
                            ),
                            InkWell(
                              onTap: () {
                                featuredProviderOurTake.website
                                    ?.launchUrlInBrowser();
                              },
                              child: Text(
                                "View ${featuredProviderOurTake.name} >",
                                style: context.textTheme.bodyMedium?.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: context.colorScheme.primary),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Text(
                      "${featuredProviderOurTake.ourTake}",
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget _disclaimerWidget({required BuildContext context}) {
    return Container(
      width: context.sw,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: context.colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Text(_disclaimerText, style: context.textTheme.bodyMedium),
    );
  }

  Widget _ceoInformation({required BuildContext context}) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.loadingCeoInfo,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    CachedNetworkImageProvider("${state.ceoInfo?.profilePic}"),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${state.ceoInfo?.name}",
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    "${state.ceoInfo?.position}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              _navigationButtons(context: context),
            ],
          ),
        );
      },
    );
  }

  Widget _navigationButtons({required BuildContext context}) {
    Color disableColor=context.colorScheme.primary.withOpacity(0.3);
    Color enableColor=context.colorScheme.primary;

    return Row(
      children: [
        InkWell(
          onTap:  featuredIndex==0?null:(){
            setState(() {
              featuredIndex=featuredIndex-1;
            });
          },
          child: CircleAvatar(
              backgroundColor: featuredIndex==0?disableColor:enableColor,
              radius: 20,
              child: Icon(
                Icons.arrow_back,
                color: context.colorScheme.onSecondary,
              )),
        ),
        const SizedBox(
          width: 6,
        ),
        InkWell(
          onTap:  featuredIndex==widget.cubit.state.featuredProvidersOurTake.length-1?null:(){
            setState(() {
              featuredIndex=featuredIndex+1;
            });
          },
          child: CircleAvatar(
            backgroundColor:featuredIndex==widget.cubit.state.featuredProvidersOurTake.length-1?
            disableColor:
            context.colorScheme.primary,
            radius: 20,
            child: Icon(
              Icons.arrow_forward,
              color: context.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }


  final String _disclaimerText =
      '''Disclaimer: This is our opinions, meant to help you make a decision and not a factual disclaimer of the company. Our team has attempted to make it as accurate as possible at the time of publishing
  ''';
}
