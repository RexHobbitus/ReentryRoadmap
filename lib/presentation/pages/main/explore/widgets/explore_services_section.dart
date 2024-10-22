import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';

import '../../../../../domain/entities/login_user.dart';
import '../../../../widgets/service_card.dart';
import 'explore_services_slider.dart';

class ExploreServicesSection extends StatelessWidget {
  final ExploreCubit cubit;

  const ExploreServicesSection({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStore, LoginUser>(
      bloc: cubit.userStore,
      builder: (context, state) {
        return Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxWidth > 500
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:state.isLoggedIn?_loggedInUserHeadings(context: context):_loggedInUserHeadings(context: context),
                )
                    : Column(children:state.isLoggedIn?_loggedInUserHeadings(context: context):_loggedInUserHeadings(context: context));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            LayoutBuilder(
              builder: (context, constraints) {

                // Define the item width (you can adjust this value as needed)
                double itemWidth = 280.0;
                // Calculate the number of columns based on the screen width
                int crossAxisCount = (constraints.maxWidth / itemWidth).floor();
                return crossAxisCount > 1
                    ? AlignedGridView.count(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const ServiceCard();
                  },
                )
                    : const ExploreServicesSlider();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _loggedInUserHeadings({required BuildContext context}) {
    return [
      Text(
        "Recommended Services for you",
        style:
        context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      InkWell(
        onTap: (){},
        child: Text(
          "View All >",
          style: context.textTheme.titleMedium?.copyWith(
              color: context.themeData.colorScheme.tertiary,
              decoration: TextDecoration.underline,
              height: 2),
        ),
      ),
    ];
  }

  List<Widget> _notLoggedInUserHeadings({required BuildContext context}) {
    return [
      Text(
        "Popular Services",
        style:
        context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      InkWell(
        onTap: (){},
        child: Text(
          "Get Personalized Recommendations >",
          style: context.textTheme.titleMedium?.copyWith(
              color: context.themeData.colorScheme.tertiary,
              decoration: TextDecoration.underline,
              height: 2),
        ),
      ),
    ];
  }

}
