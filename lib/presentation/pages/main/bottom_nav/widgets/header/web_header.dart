import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/bottom_nav_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/bottom_nav/widgets/header/web_for_provider_menu.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/entities/app_user.dart';
import '../../../../../../domain/stores/user_store.dart';
import '../../../../../../service_locator/service_locator.dart';
import 'web_notification_popup.dart';

class WebHeader extends StatelessWidget {
  final BottomNavCubit cubit;

  WebHeader({super.key, required this.cubit});

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
                  _forProviderMenu(context),
                  _webMenu(
                    title: "Explore",
                    context: context,
                    onTap: () {
                      bottomNavCubit.onMenuTapped(0, context);
                    },
                    isSelected: bottomNavState.currentIndex == 0,
                  ),
                  _webMenu(
                    title: "My Services",
                    context: context,
                    onTap: () {
                      bottomNavCubit.onMenuTapped(1, context);
                    },
                    isSelected: bottomNavState.currentIndex == 1,
                  ),
                  _webMenu(
                    title: "Write a Review",
                    context: context,
                    onTap: () {
                      bottomNavCubit.onMenuTapped(3, context);
                    },
                    isSelected: bottomNavState.currentIndex == 3,
                  ),
                  userState.isLoggedIn
                      ? Row(
                          children: [
                            _notificationPopup(context),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                bottomNavCubit.onMenuTapped(2, context);
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
                              height: 45,
                              isSecondary: true,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomButton(
                              text: "Sign Up",
                              onTap: cubit.signupAction,
                              width: 100,
                              height: 45,
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
            style: AppStyle.webMenuTextStyle(context, isSelected: isSelected),
          )),
    );
  }

  final CustomPopupMenuController _notificationPopUpController =
      CustomPopupMenuController();
  final CustomPopupMenuController _providerDropdownController =
      CustomPopupMenuController();

  Widget _notificationPopup(BuildContext context) {
    return CustomPopupMenu(
      menuBuilder: () => const WebNotificationPopup(),
      pressType: PressType.singleClick,
      verticalMargin:5,
      controller: _notificationPopUpController,
      child: SvgPicture.asset(Assets.notification),
    );
  }

  Widget _forProviderMenu(BuildContext context) {
    return CustomPopupMenu(
      menuBuilder: () => const WebForProviderMenu(),
      pressType: PressType.singleClick,
      verticalMargin:5,
      controller: _providerDropdownController,
      child: IgnorePointer(
          child: TextButton.icon(
              onPressed: (){},
              icon:  Icon(Icons.keyboard_arrow_down,size: 15,
              color: context.colorScheme.onSurface,
              ),
              iconAlignment: IconAlignment.end,
              label: Text(
                "For Provider",
                style: AppStyle.webMenuTextStyle(context),
              ))),
    );
  }
}
