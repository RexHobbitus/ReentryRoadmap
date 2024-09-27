import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/entities/app_user.dart';
import '../../../../../../domain/stores/user_store.dart';
import '../../../../../../service_locator/service_locator.dart';

class WebHeader extends StatelessWidget {
  final BottomNavCubit cubit;

  const WebHeader({super.key, required this.cubit});

  BottomNavCubit get bottomNavCubit => getIt();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        bloc: getIt(),
        builder: (context, bottomNavState) {
          return BlocBuilder<UserStore, AppUser>(
            bloc: cubit.userStore,
            builder: (context, userState) {
              return Row(
                children: [
                  _webMenu(
                    title: "Explore",
                    context: context,
                    onTap: () {
                      bottomNavCubit.changeIndex(0);
                    },
                    isSelected: bottomNavState.currentIndex == 0,
                  ),
                  _webMenu(
                    title: "My Services",
                    context: context,
                    onTap: () {
                      bottomNavCubit.changeIndex(1);
                    },
                    isSelected: bottomNavState.currentIndex == 1,
                  ),
                  _webMenu(
                    title: "Write a Review",
                    context: context,
                    onTap: () {
                      bottomNavCubit.changeIndex(3);
                    },
                    isSelected: bottomNavState.currentIndex == 3,
                  ),
                  userState.isLoggedIn
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(Assets.notification)),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: (){
                                bottomNavCubit.changeIndex(2);
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: context.colorScheme.secondary,
                              ),
                            ),
                          ],
                        )
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
                        )
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _webMenu(
      {required BuildContext context,
      required String title,
      bool isSelected = false,
      VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          onPressed: onTap,
          child: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? context.colorScheme.primary : null),
          )),
    );
  }
}
