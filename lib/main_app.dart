import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_router.dart';
import 'core/theme/light_theme.dart';
import 'core/utils/constants.dart';
import 'presentation/widgets/something_went_wrong.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      routerConfig: AppRouter.router,
      builder: (BuildContext context, Widget? child) {
        ErrorWidget.builder = (errorDetails) => const SomethingWentWrong();
        final mediaQuery = MediaQuery.of(context);
        final isWebVersion = mediaQuery.size.width > 500;
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler:  TextScaler.linear(isWebVersion?1.2:1),
          ),
          child: child!,
        );
      },
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: LIGHT_THEME,
      //darkTheme: DARK_THEME,
    );
  }
}
