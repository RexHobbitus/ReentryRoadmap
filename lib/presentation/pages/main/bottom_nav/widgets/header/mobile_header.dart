import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_cubit.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/entities/app_user.dart';
import '../../../../../../domain/stores/user_store.dart';
import '../../../../../widgets/custom_button.dart';

class MobileHeader extends StatelessWidget {
  final BottomNavCubit cubit;

  const MobileHeader({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      child: BlocBuilder<UserStore, AppUser>(
        bloc: cubit.userStore,
        builder: (context, state) {
          return state.isLoggedIn
              ? IconButton(
                  onPressed: () {}, icon: SvgPicture.asset(Assets.notification))
              : Row(
                  children: [
                    CustomButton(
                      text: "Log In",
                      onTap: cubit.loginAction,
                      width: 100,
                      height: 35,
                      isSecondary: true,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomButton(
                      text: "Sign Up",
                      onTap: cubit.signupAction,
                      width: 100,
                      height: 35,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
