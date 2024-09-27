import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'profile_initial_params.dart';
import 'profile_state.dart';
import 'profile_navigator.dart';


class ProfileCubit extends Cubit<ProfileState> {
ProfileNavigator navigator;
ProfileCubit({required this.navigator}) : super(ProfileState.initial());

BuildContext get context => navigator.context;

 onInit(ProfileInitialParams initialParams){

  }

}
