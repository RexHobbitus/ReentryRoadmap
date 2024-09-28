import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/explore_cubit.dart';
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
      child:  LayoutBuilder(builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: [
              SizedBox(
                width: constraints.maxWidth>kMenuBreakPoint?constraints.maxWidth*0.35:null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UserStore,AppUser>(
                      bloc: cubit.userStore,
                      builder: (context, state) {
                        return Text(
                          state.isLoggedIn?"Welcome back ${state.name}!":"Hello There!",
                          style: context.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                    Text(
                      "What are you looking for today?",
                      style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.themeData.colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
              constraints.maxWidth>kMenuBreakPoint?
              const ExploreWebSearchField():
              CustomTextField(
                controller: TextEditingController(),
                hint: "Search",
                suffixPath: Assets.search,
                bottomPadding: 0,
                width: constraints.maxWidth > 500 ? 500 : constraints.maxWidth,
              ),
            ],
          );
        }
      ),
    );
  }
}
