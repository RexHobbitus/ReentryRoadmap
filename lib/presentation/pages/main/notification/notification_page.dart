import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/notification_tile.dart';
import 'notification_cubit.dart';
import 'notification_initial_params.dart';
import 'notification_state.dart';

class NotificationPage extends StatefulWidget {
  final NotificationCubit cubit;
  final NotificationInitialParams initialParams;

  static const path = '/NotificationPage';

  const NotificationPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  NotificationCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(kScreenHorizontalPadding),
        itemBuilder: (context, index) {
          return const NotificationTile();
        },
      ),
    );
  }
}
