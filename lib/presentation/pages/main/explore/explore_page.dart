import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/widgets/banner/explore_banner_section.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/widgets/explore_services_section.dart';
import '../../../widgets/custom_scroll_view.dart';
import 'explore_cubit.dart';
import 'explore_initial_params.dart';
import 'widgets/explore_footer_section.dart';
import 'widgets/explore_search_section.dart';
import 'widgets/explore_service_categories_section.dart';
class ExplorePage extends StatefulWidget {
  final ExploreCubit cubit;
  final ExploreInitialParams initialParams;

  static const path = '/ExplorePage';

  const ExplorePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExploreState();
}

class _ExploreState extends State<ExplorePage> {
  ExploreCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExploreSearchSection(
                    cubit: cubit,
                  ),
                  ExploreBannerSection(cubit: cubit),
                  ExploreServiceCategoriesSection(cubit: cubit),
                  const SizedBox(
                    height: 60,
                  ),
                  ExploreServicesSection(cubit: cubit),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const ExploreFooterSection(),
          ],
        ),
      ),
    );
  }
}
