import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import 'more_cubit.dart';
import 'more_initial_params.dart';

class MorePage extends StatefulWidget {
  final MoreCubit cubit;
  final MoreInitialParams initialParams;

  static const path = '/MorePage';

  const MorePage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });

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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return CustomButton(
                text: 'Check In',
                width: constraints.maxWidth > 350 ? 200 : constraints.maxWidth,
                onTap: cubit.openCheckIn,
              );
            },
          )
        ],
      )),
    );
  }
}
