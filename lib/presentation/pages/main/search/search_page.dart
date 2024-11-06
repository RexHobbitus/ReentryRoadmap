import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_categories_menu.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_provider_list.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_textfield_section.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/widgets/search_web_filter_categories.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import 'search_cubit.dart';
import 'search_initial_params.dart';

class SearchPage extends StatefulWidget {
  final SearchCubit cubit;
  final SearchInitialParams initialParams;

  static const path = '/SearchPage';

  const SearchPage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });

  @override
  State<SearchPage> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  SearchCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.sizeOf(context).width > kMenuBreakPoint;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: max(28, MediaQuery.sizeOf(context).width * 0.045)),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SearchTextFieldSection(cubit: cubit),
            SizedBox(height: isBigScreen ? 40 : 8),
            SearchCategoriesMenu(cubit: cubit),
            SizedBox(height: isBigScreen ? 15 : 8),
            Divider(height: 1, color: context.colorScheme.tertiaryContainer),
            Expanded(
              child: SingleChildScrollView(
                controller: cubit.scrollController,
                child: CustomResponsiveBuilder(
                  builder: (context, constraints, device) =>  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (constraints.maxWidth > 1000) ...[
                        Expanded(flex: 2, child: SearchWebFilterCategories(cubit: cubit)),
                        const SizedBox(width: 60),
                      ],
                      Expanded(flex: 10, child: SearchProviderList(cubit: cubit, isBigScreen: isBigScreen)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
