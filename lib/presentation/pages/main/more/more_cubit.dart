import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'more_initial_params.dart';
import 'more_state.dart';
import 'more_navigator.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreNavigator navigator;

  MoreCubit({
    required this.navigator,
  }) : super(MoreState.initial());

  BuildContext get context => navigator.context;

  onInit(MoreInitialParams initialParams) {}


}
