import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/widgets/explore_header_auth_buttons.dart';
import 'package:reentry_roadmap/presentation/pages/main/explore/widgets/explore_services_section.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import '../../../widgets/header_logo.dart';
import 'explore_cubit.dart';
import 'explore_initial_params.dart';
import 'widgets/explore_popular_services_section.dart';
import 'widgets/explore_search_section.dart';
import 'widgets/explore_take_quiz_section.dart';

class ExplorePage extends StatefulWidget {
  final ExploreCubit cubit;
  final ExploreInitialParams initialParams;

  static const path = '/ExplorePage';

  const ExplorePage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExploreState();
}

class _ExploreState extends State<ExplorePage> {
  ExploreCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        elevation: 0.5,
        leading: const HeaderLogo(),
        actions: [
          !cubit.userStore.state
              ? ExploreHeaderAuthButtons(
                  onSignUp: () {},
                  onLogin: () {},
                )
              : IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(Assets.notification)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ExploreSearchSection(),
              const ExploreTakeQuizSection(),
              ExploreServicesSection(cubit: cubit),
              const ExplorePopularServicesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
