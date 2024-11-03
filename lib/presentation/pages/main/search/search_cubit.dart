import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';

import 'search_initial_params.dart';
import 'search_navigator.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchNavigator navigator;
  UserStore userStore;

  SearchCubit({
    required this.navigator,
    required this.userStore,
  }) : super(SearchState.initial());

  BuildContext get context => navigator.context;

  onInit(SearchInitialParams initialParams) {}
}
