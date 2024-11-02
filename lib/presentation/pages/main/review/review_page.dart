import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/review_search_section.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/review_service_section.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_scroll_view.dart';
import '../../../../core/utils/constants.dart';
import '../explore/widgets/explore_search_section.dart';
import 'review_cubit.dart';
import 'review_initial_params.dart';
import 'review_state.dart';

class ReviewPage extends StatefulWidget {
  final ReviewCubit cubit;
  final ReviewInitialParams initialParams;

  static const path = '/ReviewPage';

  const ReviewPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewState();
}

class _ReviewState extends State<ReviewPage> {
  ReviewCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cubit.isLoggedIn()
          ? Center(
              child: CustomSingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kScreenHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReviewSearchSection(cubit: cubit),
                      ReviewServicesSection(cubit: cubit),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(Assets.loginLogo),
                  ),
                  const SizedBox(height: 20),
                  Text("Sign In to write a review",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
    );
  }
}
