import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'bottom_nav_cubit.dart';
import 'bottom_nav_initial_params.dart';
import 'bottom_nav_state.dart';

class BottomNavPage extends StatefulWidget {
  final BottomNavCubit cubit;
  final BottomNavInitialParams initialParams;

  static const path = '/BottomNavPage';

  const BottomNavPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
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
    cubit.userStore.stream.listen((data){
      setState(() {
        debugPrint("User updated////////");
      });
    });
  }

  _statusBarColor(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
  }
  @override
  Widget build(BuildContext context) {
    _statusBarColor();
    return BlocBuilder<BottomNavCubit, BottomNavState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: cubit.pages[state.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: cubit.changeIndex,
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
                  label: cubit.userStore.state.isLoggedIn?"Me":"Sign Up",
                  assetPath: Assets.signup,
                  child:cubit.userStore.state.isLoggedIn?CircleAvatar(
                    radius: 10,
                    backgroundImage: CachedNetworkImageProvider(
                      "https://deadline.com/wp-content/uploads/2023/03/Keanu-Reeves-john-wick-4.jpg"
                    ),
                  ):null,
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
            ),
          );
        });
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
        child:child??SvgPicture.asset(
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
