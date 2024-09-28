import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/widgets/header/mobile_header.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/widgets/header/web_header.dart';
import '../../../widgets/header_logo.dart';
import '../explore/explore_page.dart';
import '../more/more_page.dart';
import '../my_services/my_services_page.dart';
import '../profile/profile_page.dart';
import '../review/review_page.dart';
import 'bottom_nav_cubit.dart';
import 'bottom_nav_initial_params.dart';
import 'bottom_nav_state.dart';

class BottomNavPage extends StatefulWidget {
  final BottomNavCubit cubit;
  final BottomNavInitialParams initialParams;
  final Widget child;
  static const path = '/BottomNavPage';

  const BottomNavPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
    required this.child,

  }) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNavPage> {
  BottomNavCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
    cubit.userStore.stream.listen((data) {
      setState(() {
        debugPrint("User updated////////");
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cubit.setActiveIndex(_calculateSelectedIndex(context));
    });
  }

  _statusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    _statusBarColor();
    return BlocBuilder<BottomNavCubit, BottomNavState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: double.maxFinite,
              leading: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderLogo(),
                    constraints.maxWidth <= kMenuBreakPoint
                        ? MobileHeader(
                            cubit: cubit,
                          )
                        : WebHeader(
                            cubit: cubit,
                          )
                  ],
                );
              }),
            ),
            // body: cubit.pages[state.currentIndex],
            body: widget.child,
            bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth>kMenuBreakPoint?const SizedBox.shrink():
              BottomNavigationBar(
                currentIndex: _calculateSelectedIndex(context),
                onTap: (int idx) => cubit.onMenuTapped(idx, context),
                items: [
                  _customBottomNavIcon(
                    label: "Explore",
                    assetPath: Assets.explore,
                    isSelected: state.currentIndex == 0,
                  ),
                  _customBottomNavIcon(
                    label: "My Services",
                    assetPath: Assets.myServices,
                    isSelected: state.currentIndex == 1,
                  ),
                  _customBottomNavIcon(
                    label: cubit.userStore.state.isLoggedIn ? "Me" : "Sign Up",
                    assetPath: Assets.signup,
                    child: cubit.userStore.state.isLoggedIn
                        ? const CircleAvatar(
                            radius: 10,
                            backgroundImage: CachedNetworkImageProvider(
                                "https://deadline.com/wp-content/uploads/2023/03/Keanu-Reeves-john-wick-4.jpg"),
                          )
                        : null,
                    isSelected: state.currentIndex == 2,
                  ),
                  _customBottomNavIcon(
                    label: "Review",
                    assetPath: Assets.review,
                    isSelected: state.currentIndex == 3,
                  ),
                  _customBottomNavIcon(
                    label: "More",
                    assetPath: Assets.more,
                    isSelected: state.currentIndex == 4,
                  ),
                ],
              );
            }),
          );
        });
  }


  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(ExplorePage.path)) {
      return 0;
    }
    if (location.startsWith(MyServicesPage.path)) {
      return 1;
    }
    if (location.startsWith(ProfilePage.path)) {
      return 2;
    }
    if (location.startsWith(ReviewPage.path)) {
      return 3;
    }
    if (location.startsWith(MorePage.path)) {
      return 4;
    }
    return 0;
  }





  BottomNavigationBarItem _customBottomNavIcon(
      {required String label,
      required String assetPath,
      Widget? child,
      bool isSelected = false}) {
    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: child ??
            SvgPicture.asset(
              assetPath,
              color: isSelected
                  ? context.themeData.primaryColor
                  : context.themeData.colorScheme.secondary,
              // height: 30,
            ),
      ),
    );
  }
}
