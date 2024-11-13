import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/bloc/photos_bloc/photos_bloc.dart';
import 'package:reentry_roadmap/bloc/photos_bloc/photos_event.dart';
import 'package:reentry_roadmap/bloc/program_details_bloc/program_details_bloc.dart';
import 'bloc/program_details_bloc/program_details_event.dart';
import 'bloc/provider_info_bloc/provider_info_bloc.dart';
import 'bloc/provider_info_bloc/provider_info_event.dart';
import 'bloc/review_bloc/review_bloc.dart';
import 'bloc/review_bloc/review_event.dart';
import 'core/routes/app_router.dart';
import 'core/theme/light_theme.dart';
import 'core/utils/constants.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReviewBloc>(
          create: (_) => ReviewBloc()
            ..add(LoadNewReviews())
            ..add(LoadOldReviews()),
        ),
        BlocProvider(
          create: (context) => ProviderInfoBloc()..add(LoadProviderInfo()),
        ),
        BlocProvider(
          create: (context) => ProgramDetailsBloc(FirebaseFirestore.instance)
            ..add(LoadProgramDetails()),
        ),
        BlocProvider(
          create: (context) => PhotosBloc()..add(LoadPhotos()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        // builder: (BuildContext context, Widget? child) {
        //   ErrorWidget.builder = (errorDetails) => const SomethingWentWrong();
        //   return MediaQuery(
        //     data: MediaQuery.of(context).copyWith(
        //       textScaler: TextScaler.noScaling,
        //     ),
        //     child: child,
        //   );
        // },
        title: kAppName,
        debugShowCheckedModeBanner: false,
        theme: LIGHT_THEME,
      ),
    );
  }
}
