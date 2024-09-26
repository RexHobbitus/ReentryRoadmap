import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'review_cubit.dart';
import 'review_initial_params.dart';
import 'review_state.dart';

class ReviewPage extends StatefulWidget {
  final ReviewCubit cubit;
  final ReviewInitialParams initialParams;

  static const path = '/ReviewPage';

  const ReviewPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewState();
}

class _ReviewState extends State<ReviewPage> {
  ReviewCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(child: Text("Review"),),
    );
  }
}
