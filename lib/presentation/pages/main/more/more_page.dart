import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/presentation/pages/inbox/inbox_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_page.dart';
import 'more_cubit.dart';
import 'more_initial_params.dart';
import 'more_state.dart';

class MorePage extends StatefulWidget {
  final MoreCubit cubit;
  final MoreInitialParams initialParams;

  static const path = '/MorePage';

  const MorePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<MorePage> createState() => _MoreState();
}

class _MoreState extends State<MorePage> {
  MoreCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("More page"),
      ),
    );
  }
}
