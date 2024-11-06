import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/settings/widgets/setttings_appbar_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_scroll_view.dart';

import 'settings_cubit.dart';
import 'settings_initial_params.dart';
import 'widgets/settings_data_sharing_section.dart';
import 'widgets/settings_notification_tile.dart';
import 'widgets/settings_password_change_section.dart';

class SettingsPage extends StatefulWidget {
  final SettingsCubit cubit;
  final SettingsInitialParams initialParams;

  static const path = '/SettingsPage';

  const SettingsPage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kScreenHorizontalPadding),
          child: Column(
            children: [
              const SetttingsAppbarWidget(),
              SettingsPasswordChangeSection(cubit: cubit),
              const SizedBox(height: 16),
              const SettingsNotificationTile(),
              const SizedBox(height: 6),
              SettingsDataSharingSection(cubit: cubit),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
