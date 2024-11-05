import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'learn_more_initial_params.dart';
import 'learn_more_state.dart';
import 'learn_more_navigator.dart';


class LearnMoreCubit extends Cubit<LearnMoreState> {
LearnMoreNavigator navigator;
LearnMoreCubit({required this.navigator}) : super(LearnMoreState.initial());

BuildContext get context => navigator.context;

 onInit(LearnMoreInitialParams initialParams){

  }

}
