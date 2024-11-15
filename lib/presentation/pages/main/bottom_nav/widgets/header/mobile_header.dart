import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_cubit.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/entities/app_user.dart';
import '../../../../../../domain/stores/user_store.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/header_auth_buttons.dart';

class MobileHeader extends StatelessWidget {
  final BottomNavCubit cubit;

  const MobileHeader({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      child: BlocBuilder<UserStore, LoginUser>(
        bloc: cubit.userStore,
        builder: (context, state) {
          return state.isLoggedIn
              ? IconButton(
                  onPressed: cubit.notificationAction,
                  icon: SvgPicture.asset(Assets.notification))
              : HeaderAuthButtons(
                  loginAction: cubit.loginAction,
                  signUpAction: cubit.signUpAction,
                  isMobileView: true,
                );
        },
      ),
    );
  }
}
