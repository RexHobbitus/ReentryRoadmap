import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class ExploreBannerSection extends StatelessWidget {
  final ExploreCubit cubit;

  const ExploreBannerSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.themeData.colorScheme.secondary),
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
                  Text(
                    state.isLoggedIn
                        ? "Provide a Check In to get the best matches!"
                        : "Take our quiz to get personalized results!",
                    style: context.textTheme.titleLarge?.copyWith(
                        color: context.themeData.colorScheme.onSecondary,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.isLoggedIn
                        ? "Update us on your reentry journey to help us better understand your needs."
                        : "Share your reentry journey with us to help us better understand your needs.",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.themeData.colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              LayoutBuilder(builder: (context, constraints) {
                return CustomButton(
                  text: "Learn More",
                  width:
                      constraints.maxWidth > 350 ? 200 : constraints.maxWidth,
                  onTap: () {},
                );
              })
            ],
          );
        },
      ),
    );
  }
}
