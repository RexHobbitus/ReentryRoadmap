import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';

import '../../../widgets/custom_scroll_view.dart';
import 'account_cubit.dart';
import 'account_initial_params.dart';
import 'widgets/account_tile.dart';

class AccountPage extends StatefulWidget {
  final AccountCubit cubit;
  final AccountInitialParams initialParams;

  static const path = '/AccountPage';

  const AccountPage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountCubit get cubit => widget.cubit;

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
          padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              AccountTile(
                text: 'Profile',
                iconPath: Assets.settings,
                onTap: widget.cubit.openProfile,
              ),
              const SizedBox(
                height: 8,
              ),
              AccountTile(
                text: 'Settings',
                iconPath: Assets.settings,
                onTap: widget.cubit.openSettings,
              ),
              const SizedBox(
                height: 8,
              ),
              AccountTile(
                text: 'Messages',
                iconPath: Assets.messages,
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              AccountTile(
                text: 'Logout',
                iconPath: Assets.signup,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
