import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_cubit.dart';
import 'splash_initial_params.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  final SplashCubit cubit;
  final SplashInitialParams initialParams;

  static const path = '/SplashPage';

  const SplashPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  SplashCubit get cubit => widget.cubit;

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
      body:const Center(child: Text("This is splash page"),),
    );
  }
}
