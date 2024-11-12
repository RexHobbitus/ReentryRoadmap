import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

class DesktopTabBar extends StatefulWidget {
  const DesktopTabBar({super.key, required this.tabController, this.onTap});
final Function( int index)? onTap;
  final TabController tabController;

  @override
  State<DesktopTabBar> createState() => _DesktopTabBarState();
}

class _DesktopTabBarState extends State<DesktopTabBar> {
  @override
  void initState() {
    widget.tabController.addListener(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            if (!mounted) return;
            setState(() {});
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
     indicatorPadding:EdgeInsets.only(right: 16),
      onTap: widget.onTap,
        controller: widget.tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          color: context.themeData.colorScheme.secondary,
          // Background color of selected tab
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
       labelPadding:  EdgeInsets.only(right: 16),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        isScrollable: false,
        tabs: List.generate(
          kMyServicesTabBarItemsDesktop.length,
          (index) {
            return Tab(
              height: 60,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
              //  margin:
                //    const EdgeInsets.only(right: 10),
                decoration: widget.tabController.index == index
                    ? null
                    : BoxDecoration(
                        color: context.themeData.cardColor,
                        // Light background for unselected tabs
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: Center(
                  child: Text(kMyServicesTabBarItemsDesktop[index],
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                          color: widget.tabController.index == index
                              ? context.themeData.colorScheme.onSecondary
                              : context.themeData.colorScheme.onSurface)),
                ),
              ),
            );
          },
        ));
  }
}
