import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_cubit.dart';
import 'profile_initial_params.dart';
import 'profile_state.dart';

class ProfilePage extends StatefulWidget {
  final ProfileCubit cubit;
  final ProfileInitialParams initialParams;

  static const path = '/ProfilePage';

  const ProfilePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  ProfileCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(child: Text("Signup/Profile page"),),
    );
  }
}
