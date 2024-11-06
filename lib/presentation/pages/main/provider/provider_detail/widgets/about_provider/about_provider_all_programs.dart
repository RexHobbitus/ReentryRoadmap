import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/program.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_title.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_section_container.dart';
import '../../../../../../widgets/custom_check_box.dart';
import '../provider_detail_button.dart';
import 'about_provider_categories_sub_section.dart';
import 'about_provider_eligibility_and_feature_sub_section.dart';

class AboutProviderAllPrograms extends StatefulWidget {
  final ProviderDetailCubit cubit;

  AboutProviderAllPrograms({super.key, required this.cubit});

  @override
  State<AboutProviderAllPrograms> createState() =>
      _AboutProviderAllProgramsState();
}

class _AboutProviderAllProgramsState extends State<AboutProviderAllPrograms> {
  List<Program> programs = [];

  ProviderDetailState get state => widget.cubit.state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    programs = state.provider.onboardingInfo?.programs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return BlocBuilder<UserStore, LoginUser>(
        bloc: widget.cubit.userStore,
        builder: (context, user) {
          return programs.isEmpty?const SizedBox.shrink():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ProviderDetailTitle(title: "All Programs"),
                  constraints.maxWidth > 400
                      ? user.isLoggedIn
                          ? ProviderDetailButton(
                              title: "Suggest on edit",
                              icon: Icons.edit,
                              onTap: widget.cubit.suggestEditAction,
                            )
                          : const SizedBox.shrink()
                      : const SizedBox.shrink()
                ],
              ),
              for (var program in programs)
                CustomSectionContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program.name ?? "N/A",
                        style: context.textTheme.titleMedium,
                      ),
                      user.isLoggedIn
                          ? const CustomCheckBox(
                              text: "Select to Contact",
                            )
                          : const SizedBox.shrink(),
                      user.isLoggedIn
                          ? const SizedBox(
                              height: 20,
                            )
                          : const SizedBox.shrink(),
                      AboutProviderCategoriesSubSection(
                        cubit: widget.cubit,
                      ),
                      AboutProviderEligibilityAndFeatureSubSection(
                        isLoggedIn: user.isLoggedIn,
                        eligibility: program.eligibilityCriteria ?? [],
                        features: program.features ?? [],
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
