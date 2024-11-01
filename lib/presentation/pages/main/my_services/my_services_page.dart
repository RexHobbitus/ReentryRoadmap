import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/desktop_tab_bar.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/no_services_view.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/services_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import 'my_services_cubit.dart';
import 'my_services_initial_params.dart';

class MyServicesPage extends StatefulWidget {
  final MyServicesCubit cubit;
  final MyServicesInitialParams initialParams;

  static const path = '/MyServicesPage';

  const MyServicesPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<MyServicesPage> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServicesPage>
    with SingleTickerProviderStateMixin {
  MyServicesCubit get cubit => widget.cubit;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: kMyServicesTabBarItems.length, vsync: this);
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

      Padding(
      padding:  EdgeInsets.symmetric(horizontal:Responsive.isDesktop(context)?80: 24),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:  Size.fromHeight(Responsive.isDesktop(context)?210:150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Responsive.isDesktop(context)?30.verticalSpace: 14.verticalSpace,
                Text(
                  "My Services",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500,fontSize: Responsive.isDesktop(context)?30:20),
                ),
                Responsive.isDesktop(context)?30.verticalSpace: 14.verticalSpace,
                Responsive.isDesktop(context)?DesktopTabBar(
                  tabController: tabController,
                ):TabBar(
                  controller: tabController,
                  indicator: null,
                  isScrollable: Responsive.isMobile(context) ,
                  labelColor: context.colorScheme.primary,
                  labelStyle: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,

                  ),
                  unselectedLabelColor: context.colorScheme.onSurface,
                  indicatorColor: Colors.transparent,
                  unselectedLabelStyle:
                  context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: kMyServicesTabBarItems
                      .map((title) => Tab(
                    text: title,
                  ))
                      .toList(),
                ),

                  Responsive.isMobile(context)  ? Column(
                    children: [
                      Divider(
                      height: 20,
                      thickness: 1.5,
                      color: context.colorScheme.tertiaryContainer,
                      indent: 0,
                                      ),
                      20.verticalSpace,
                    ],
                  ):40.verticalSpace,
              ],
            )),
        body: NoServicesView()

        // TabBarView(
        //   physics: Responsive.isDesktop(context)? NeverScrollableScrollPhysics():BouncingScrollPhysics(),
        //   controller: tabController,
        //   children: kMyServicesTabBarItems.map((title) {
        //     return CustomResponsiveBuilder(
        //       builder: (context, constraints, deviseSize) {
        //         return AlignedGridView.count(
        //           crossAxisCount: Responsive.getResponsiveValue(context, 1, 2, 4,largeTablet: 3),
        //           mainAxisSpacing: 13,
        //           crossAxisSpacing: 13,
        //           shrinkWrap: true,
        //           primary: false,
        //
        //           itemCount: 4,
        //           itemBuilder: (context, index) {
        //             // Provider provider =state.loading?
        //             // Provider.shimmer():
        //             //  state.services[index];
        //             return ServicesTile(
        //               onTap: (p0) {},
        //               myService: MyService(
        //                   name: "OpenGate OakLand",
        //                   address: "5506 Martha Ave, abc",
        //                   imgUrl: kPlaceHolderImage),
        //             );
        //           },
        //         );
        //       },
        //     );
        //   }).toList(),
        // ),
      ),
    );
  }
}
