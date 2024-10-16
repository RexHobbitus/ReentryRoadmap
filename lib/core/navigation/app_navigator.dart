import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../utils/constants.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  push(BuildContext context, String path, Object? parameter) {
    context.push(path, extra: parameter);
  }

  go(BuildContext context, String path, Object? parameter) {
    context.go(path, extra: parameter);
  }

  replace(BuildContext context, String path, Object? parameter) {
    context.replace(path, extra: parameter);
  }

  pushAndClearAllPrevious(
      BuildContext context, String path, Object? parameter) {
    while (context.canPop() == true) {
      context.pop();
    }
    context.pushReplacement(path, extra: parameter);
  }

  showBottomSheet(BuildContext context, Widget page,
      {double? height, EdgeInsets? padding}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context)
            .viewInsets
            .copyWith(left: 20, right: 20, top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          // Set clipBehavior to Clip.antiAlias
          child: page,
        ),
      ),
    );
  }

  pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  showDialogBox(BuildContext context, Widget page) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Container(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                margin: const EdgeInsets.symmetric(
                    horizontal: kScreenHorizontalPadding),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: page,
              )));
        });
  }
}
