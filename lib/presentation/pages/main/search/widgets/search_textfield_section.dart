import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_field/search_mobile_field.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_field/search_web_field.dart';

class SearchTextFieldSection extends StatelessWidget {
  final SearchCubit cubit;

  const SearchTextFieldSection({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final children = [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UserStore, LoginUser>(
                bloc: cubit.userStore,
                builder: (context, state) {
                  return Text(
                    state.isLoggedIn
                        ? "Welcome back ${(state.role == "user") ? (state.data as AppUser).onboardingInfo?.personalInfo?.firstName ?? "" : (state.data as Provider).email}"
                        : "Hello There!",
                    style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  );
                },
              ),
              Text(
                "What are you looking for today?",
                style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: context.themeData.colorScheme.tertiary),
              ),
            ],
          ),
          const SizedBox(height: 12, width: 28),
          if (constraints.maxWidth > kMenuBreakPoint) ...[
            Expanded(child: SearchWebField(cubit:cubit)),
          ] else ...[
             SearchMobileField(cubit: cubit,),
          ]
        ];
        if (constraints.maxWidth > kMenuBreakPoint) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        }
      },
    );
  }
}
