import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../widgets/service_card.dart';

class ExploreServicesSlider extends StatefulWidget {
  final ExploreCubit cubit;

  const ExploreServicesSlider({
    super.key,
    required this.cubit,
  });

  @override
  State<ExploreServicesSlider> createState() => _ExploreServicesSliderState();
}

class _ExploreServicesSliderState extends State<ExploreServicesSlider> {
  int _activeIndex = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  ExploreState get state => widget.cubit.state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: state.loading ? 2 : state.services.length,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 0.64,
              initialPage: _activeIndex,
              onPageChanged: (index, _) {
                setState(() {
                  _activeIndex = index;
                });
              }),
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  ServiceCard(
            onTap: widget.cubit.openProviderDetail,
            provider:
                state.loading ? Provider.shimmer() : state.services[itemIndex],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  if (_activeIndex > 0) {
                    setState(() {
                      _activeIndex--;
                    });
                    _changeIndex();
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                )),
            AnimatedSmoothIndicator(
              activeIndex: _activeIndex,
              count: state.loading?4:state.services.length,
              effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 20,
                  activeDotColor: context.colorScheme.secondary),
            ),
            IconButton(
                onPressed: () {
                  if (_activeIndex < 3) {
                    setState(() {
                      _activeIndex++;
                    });
                    _changeIndex();
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios, size: 15)),
          ],
        ),
      ],
    );
  }

  _changeIndex() {
    buttonCarouselController.animateToPage(_activeIndex);
  }
}
