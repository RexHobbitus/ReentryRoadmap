import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'review_initial_params.dart';
import 'review_state.dart';
import 'review_navigator.dart';


class ReviewCubit extends Cubit<ReviewState> {
ReviewNavigator navigator;
ReviewCubit({required this.navigator}) : super(ReviewState.initial());

BuildContext get context => navigator.context;

 onInit(ReviewInitialParams initialParams){

  }

}
