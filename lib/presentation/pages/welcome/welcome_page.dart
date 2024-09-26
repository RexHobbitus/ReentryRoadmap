import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_cubit.dart';
import 'welcome_initial_params.dart';
import 'welcome_state.dart';

class WelcomePage extends StatefulWidget {
  final WelcomeCubit cubit;
  final WelcomeInitialParams initialParams;

  static const path = '/WelcomePage';

  const WelcomePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  WelcomeCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Welcome page"),),
    );
  }
}
