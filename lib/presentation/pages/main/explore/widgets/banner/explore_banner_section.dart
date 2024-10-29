import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class ExploreBannerSection extends StatelessWidget {
  final ExploreCubit cubit;

  const ExploreBannerSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 20, bottom: 30, right: 29, left: 29),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.themeData.colorScheme.secondary,
      ),
      child: BlocBuilder<UserStore, LoginUser>(
        bloc: cubit.userStore,
        builder: (context, state) {
          return Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.isLoggedIn
                      ? _loggedInUserText(context)
                      : _notLoggedInUserText(context),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.isLoggedIn
                        ? "Update us on your reentry journey to help us better understand your needs."
                        : "Share your reentry journey with us to help us better understand your needs.",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.themeData.colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              CustomResponsiveBuilder(builder: (context, constraints,deviceSize) {
                return CustomButton(
                  text: "Learn More",
                  width: constraints.maxWidth > 350 ? 200 : constraints.maxWidth,
                  height: 56,
                  style: context.textTheme.bodyLarge,
                  onTap: () {},
                );
              })
            ],
          );
        },
      ),
    );
  }

  Widget _notLoggedInUserText(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Take our ",
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.themeData.colorScheme.onSecondary),
            children: [
          TextSpan(
              text: "quiz",
            recognizer: TapGestureRecognizer()..onTap =cubit.quizAction,
              style: context.textTheme.titleMedium?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  decoration: TextDecoration.underline)),
          const TextSpan(text: " to get personalized results!")
        ]));
  }

  Widget _loggedInUserText(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Provide a ",
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.themeData.colorScheme.onSecondary),
            children: [
          TextSpan(
              text: "Check In",
              recognizer: TapGestureRecognizer()..onTap = cubit.checkInAction,
              style: context.textTheme.titleMedium?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  decoration: TextDecoration.underline)),
          const TextSpan(text: " to get the best matches!")
        ]));
  }
}
