import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/widgets/search_field/explore_mobile_search_field.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/widgets/search_field/explore_web_search_field.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../domain/entities/app_user.dart';
import '../../../../widgets/custom_textfield.dart';

class ExploreSearchSection extends StatelessWidget {
  final ExploreCubit cubit;

  const ExploreSearchSection({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth > kMenuBreakPoint
                  ? constraints.maxWidth * 0.35
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserStore, LoginUser>(
                    bloc: cubit.userStore,
                    builder: (context, state) {
                      return Text(
                        state.isLoggedIn
                            ? "Welcome back ${(state.role == "user") ? (state.data as AppUser).onboardingInfo?.personalInfo?.firstName ?? "" : (state.data as Provider).email}"
                            : "Hello There!",
                        style: context.textTheme.titleMedium,
                        //style: context.textTheme.displaySmall,

                      );
                    },
                  ),
                  Text(
                    "What are you looking for today?",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            constraints.maxWidth > kMenuBreakPoint
                ? const ExploreWebSearchField()
                : const ExploreMobileSearchField(),
          ],
        );
      }),
    );
  }
}
