import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'learn_more_cubit.dart';
import 'learn_more_initial_params.dart';
import 'learn_more_state.dart';

class LearnMorePage extends StatefulWidget {
  final LearnMoreCubit cubit;
  final LearnMoreInitialParams initialParams;

  static const path = '/LearnMorePage';

  const LearnMorePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<LearnMorePage> createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMorePage> {
  LearnMoreCubit get cubit => widget.cubit;

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
      body:const Center(child: Text("Learn More Page"),),
    );
  }
}
