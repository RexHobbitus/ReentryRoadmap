import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/more/more_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_page.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';
import 'bottom_nav_initial_params.dart';
import 'bottom_nav_state.dart';
import 'bottom_nav_navigator.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavNavigator navigator;

  BottomNavCubit({required this.navigator}) : super(BottomNavState.initial());

  BuildContext get context => navigator.context;

  onInit(BottomNavInitialParams initialParams) {}

  var pages=[
    ExplorePage(cubit: getIt(), initialParams: const ExploreInitialParams()),
    MyServicesPage(cubit: getIt(), initialParams: const MyServicesInitialParams()),
    ReviewPage(cubit: getIt(), initialParams: const ReviewInitialParams()),
    MorePage(cubit: getIt(), initialParams: const MoreInitialParams()),
  ];

  void changeIndex(int index){
    emit(state.copyWith(currentIndex: index));
  }

}
