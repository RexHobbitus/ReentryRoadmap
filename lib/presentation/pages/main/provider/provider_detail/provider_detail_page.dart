import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/our_take/our_take_section.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_menu_bar.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.disposeAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
        return BlocBuilder<ProviderDetailCubit, ProviderDetailState>(
          bloc: cubit,
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.loading,
              ignorePointers: state.loading,
              child: CustomScrollView(
                slivers: [
                  deviceSize == DeviceSize.mobile
                      ? SliverToBoxAdapter(
                          child: ProviderDetailHeader(
                            cubit: cubit,
                          ),
                        )
                      : const SliverToBoxAdapter(),
                  deviceSize == DeviceSize.mobile
                      ? SliverAppBar(
                          elevation: 0.0,
                          pinned: true,
                          primary: false,
                          // surfaceTintColor: Colors.red,
                          automaticallyImplyLeading: false,
                          // backgroundColor: Colors.transparent,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          titleSpacing: 0,
                          toolbarHeight: 100,
                          title: ProviderDetailMenuBar(
                            cubit: cubit,
                          ),
                        )
                      : const SliverToBoxAdapter(),
                  SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// In the case of web screen size show header here
                        deviceSize == DeviceSize.web
                            ? ProviderDetailHeader(
                                cubit: cubit,
                              )
                            : const SizedBox(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenHorizontalPadding),
                            child: Container(
                              width: deviceSize == DeviceSize.web
                                  ? null
                                  : constraints.maxWidth,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // /// In the case of web screen size show menu bar
                                  deviceSize == DeviceSize.web
                                      ? ProviderDetailMenuBar(
                                          cubit: cubit,
                                        )
                                      : const SizedBox(),
                                  BlocBuilder<ProviderDetailCubit,
                                      ProviderDetailState>(
                                    bloc: cubit,
                                    builder: (context, state) {
                                      return state.selectedMenuIndex == 0
                                          ? AboutProviderSection(
                                              cubit: cubit,
                                            )
                                          : state.selectedMenuIndex == 1
                                              ? ReviewsSection(
                                                  cubit: cubit,
                                                )
                                              : state.selectedMenuIndex == 2
                                                  ?  OurTakeSection(
                                                      cubit: cubit,
                                                    )
                                                  : PhotosSection(
                                                      cubit: cubit,
                                                    );
                                    },
                                  ),
                                  deviceSize == DeviceSize.web?const SizedBox.shrink(): ProviderDetailFooter(
                                    cubit: cubit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
