import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_title.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_section_container.dart';

import 'about_provider_categories_sub_section.dart';
import 'about_provider_eligibility_and_feature_sub_section.dart';

class AboutProviderGeneralServices extends StatelessWidget {
  final ProviderDetailCubit cubit;

  const AboutProviderGeneralServices({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return BlocBuilder<UserStore, LoginUser>(
        bloc: cubit.userStore,
        builder: (context, user) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProviderDetailTitle(title: "General Services"),
                  constraints.maxWidth > 400
                      ? user.isLoggedIn
                          ? ProviderDetailButton(
                              title: "Suggest on edit",
                              icon: Icons.edit,
                              onTap: cubit.suggestEditAction,
                            )
                          : const SizedBox.shrink()
                      : const SizedBox.shrink()
                ],
              ),
              CustomSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user.isLoggedIn
                        ? CustomCheckBox(
                            text: "Select to Contact",
                            value: cubit.selectedPrograms
                                .contains("General Services"),
                            onChange: (val) {
                              cubit.selectContactAction("General Services");
                            },
                          )
                        : const SizedBox.shrink(),
                    user.isLoggedIn
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox.shrink(),
                    AboutProviderCategoriesSubSection(
                      cubit: cubit,
                    ),
                    AboutProviderEligibilityAndFeatureSubSection(
                      isLoggedIn: user.isLoggedIn,
                      eligibility: cubit.state.provider.onboardingInfo
                              ?.generalService?.eligibilityCriteria ??
                          [],
                      features: cubit.state.provider.onboardingInfo
                              ?.generalService?.features ??
                          [],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    });
  }
}
