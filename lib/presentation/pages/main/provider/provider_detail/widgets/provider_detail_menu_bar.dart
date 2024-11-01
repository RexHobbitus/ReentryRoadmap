import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import 'provider_detail_button.dart';

class ProviderDetailMenuBar extends StatelessWidget {
  final ProviderDetailCubit cubit;

  ProviderDetailMenuBar({
    super.key,
    required this.cubit,
  });

  List<String> menus = [
    "About Provider",
    "Reviews",
    "Our Take",
    "Photos",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return BlocBuilder<ProviderDetailCubit, ProviderDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: [
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var index = 0; index < menus.length; index++)
                          TextButton(
                            onPressed: () {
                              cubit.onMenuTap(index);
                            },
                            child: Text(
                              menus[index],
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: state.selectedMenuIndex == index
                                    ? FontWeight.w600
                                    : null,
                                color: state.selectedMenuIndex == index
                                    ? context.colorScheme.primary
                                    : context.colorScheme.tertiary,
                              ),
                            ),
                          )
                      ],
                    ),
                    deviceSize == DeviceSize.web
                        ? _webButtons()
                        : const SizedBox.shrink()
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                height: 30,
              )
            ],
          );
        },
      );
    });
  }

  _webButtons() {
    return BlocBuilder<UserStore, LoginUser>(
      bloc: cubit.userStore,
      builder: (context, user) {
        return user.isLoggedIn
            ? Row(
                children: [
                  ProviderDetailButton(
                      title: "Add Review",
                      icon: Icons.add,
                      isPrimary: true,
                      onTap: cubit.addReviewAction),
                  const SizedBox(
                    width: 10,
                  ),
                  const ProviderDetailButton(
                    title: "Save",
                    icon: Icons.bookmark_border,
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
