import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_services_cubit.dart';
import 'my_services_initial_params.dart';
import 'my_services_state.dart';

class MyServicesPage extends StatefulWidget {
  final MyServicesCubit cubit;
  final MyServicesInitialParams initialParams;

  static const path = '/MyServicesPage';

  const MyServicesPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<MyServicesPage> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServicesPage> {
  MyServicesCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(child: Text("My Services"),),
    );
  }
}
