import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/our_take/our_take_section.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_menu_bar.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
import 'provider_detail_cubit.dart';
import 'provider_detail_initial_params.dart';
import 'provider_detail_state.dart';
import 'widgets/about_provider/about_provider_section.dart';
import 'widgets/photos/photos_section.dart';
import 'widgets/provider_detail_footer.dart';
import 'widgets/provider_detail_header.dart';
import 'widgets/reviews/reviews_section.dart';

class ProviderDetailPage extends StatefulWidget {
  final ProviderDetailCubit cubit;
  final ProviderDetailInitialParams initialParams;

  static const path = '/ProviderDetailPage';

  const ProviderDetailPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ProviderDetailPage> createState() => _ProviderDetailState();
}

class _ProviderDetailState extends State<ProviderDetailPage> {
  ProviderDetailCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Wrap(
                spacing: 20,
                children: [
                  ProviderDetailHeader(),
                  CustomResponsiveBuilder(
                      builder: (context, constraints, deviceSize) {
                    return Container(
                      width: deviceSize == DeviceSize.web
                          ? constraints.maxWidth - 500
                          : constraints.maxWidth,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          ProviderDetailMenuBar(
                            cubit: cubit,
                          ),
                          BlocBuilder<ProviderDetailCubit, ProviderDetailState>(
                            bloc: cubit,
                            builder: (context, state) {
                              return state.selectedMenuIndex == 0
                                  ? AboutProviderSection()
                                  : state.selectedMenuIndex == 1
                                      ? ReviewsSection(
                                          cubit: cubit,
                                        )
                                      : state.selectedMenuIndex == 2
                                          ? OurTakeSection()
                                          : PhotosSection(
                                              cubit: cubit,
                                            );
                            },
                          ),
                        ],
                      ),
                    );
                  })
                  // ProviderDetailMenuBar(
                  //   cubit: cubit,
                  // ),
                  // SliverAppBar(
                  //   elevation: 0.0,
                  //   pinned: true,
                  //   primary: false,
                  //   automaticallyImplyLeading: false,
                  //   backgroundColor: Theme.of(context).colorScheme.surface,
                  //   titleSpacing: 0,
                  //   expandedHeight: 80,
                  //   title: ProviderDetailMenuBar(
                  //     cubit: cubit,
                  //   ),
                  // ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       ProviderDetailMenuBar(
            //         cubit: cubit,
            //       ),
            //       BlocBuilder<ProviderDetailCubit, ProviderDetailState>(
            //         bloc: cubit,
            //         builder: (context, state) {
            //           return state.selectedMenuIndex == 0
            //               ? AboutProviderSection()
            //               : state.selectedMenuIndex == 1
            //                   ? ReviewsSection()
            //                   : state.selectedMenuIndex == 2
            //                       ? OurTakeSection()
            //                       : PhotosSection(
            //                           cubit: cubit,
            //                         );
            //         },
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: ProviderDetailFooter(
        cubit: cubit,
      ),
    );
  }
}
