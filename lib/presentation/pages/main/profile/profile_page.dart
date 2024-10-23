import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'profile_cubit.dart';
import 'profile_initial_params.dart';
import 'profile_state.dart';

class ProfilePage extends StatefulWidget {
  final ProfileCubit cubit;
  final ProfileInitialParams initialParams;

  static const path = '/ProfilePage';

  const ProfilePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  ProfileCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
        child: BlocBuilder<UserStore, LoginUser>(
          bloc: cubit.userStore,
          builder: (context, user) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              bloc: cubit,
              builder: (context, state) {
                return user.isLoggedIn ? Center(
                  child: CustomButton(
                    text: "Logout",
                    onTap: cubit.logoutAction,
                  ),
                ) : const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }
}
