import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import 'provider_detail_button.dart';

class ProviderDetailFooter extends StatelessWidget {
  final ProviderDetailCubit cubit;

  const ProviderDetailFooter({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return  CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return deviceSize == DeviceSize.web
          ? const SizedBox.shrink()
          : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<UserStore, LoginUser>(
                bloc: cubit.userStore,
                builder: (context, user) {
                  return user.isLoggedIn
                      ? Row(
                          children: [
                            Expanded(
                              flex:4,
                              child: ProviderDetailButton(
                                  title: "Add Review",
                                  icon: Icons.add,
                                  onTap: cubit.addReviewAction),
                            ),
                            Expanded(
                              flex:5,
                              child: ProviderDetailButton(
                                title: "Suggest on edit",
                                icon: Icons.edit,
                                onTap: cubit.suggestEditAction,
                              ),
                            ),
                             const Expanded(
                               flex:3,
                              child: ProviderDetailButton(
                                title: "Save",
                                icon: Icons.bookmark_border,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              ),
              const SizedBox(height: 10,),
              CustomButton(
                text: "Contact OpenGate",
                onTap: cubit.contactAction,
                style: context.textTheme.titleMedium,
              ),
            ],
          );
    });
  }
}
