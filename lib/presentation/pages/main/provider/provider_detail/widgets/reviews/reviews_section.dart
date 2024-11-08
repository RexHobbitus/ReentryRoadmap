import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/enums/review_sorting.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../provider_detail_dropdown.dart';
import 'customer_review_widget.dart';
import 'rating_sub_section.dart';

class ReviewsSection extends StatelessWidget {
  final ProviderDetailCubit cubit;

  const ReviewsSection({super.key, required this.cubit});

  ProviderDetailState get state => cubit.state;

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context,constraints,deviceSize) {
        return BlocBuilder<UserStore, LoginUser>(
          bloc: cubit.userStore,
          builder: (context, user) {
            return Column(
              children: [
                RatingSubSection(
                  provider: cubit.state.provider,
                ),
                constraints.maxWidth>450?
                _buttonControls(context: context,user: user):
                FittedBox(
                  child:_buttonControls(context: context,user: user)
                ),
                Skeletonizer(
                  enabled: state.loadingReviews,
                  child: (!state.loadingReviews && state.reviews.isEmpty)
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("No review yet"),
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              state.loadingReviews ? 10 : state.reviews.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomerReviewWidget(
                              review: state.loadingReviews
                                  ? ProviderReview.shimmer()
                                  : state.reviews[index],
                            );
                          },
                        ),
                )
              ],
            );
          },
        );
      }
    );
  }

  _buttonControls({required BuildContext context,required LoginUser user}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reviews",
          style: AppStyle.providerDetailTitle(context),
        ),
        const SizedBox(width: 20,),
        Row(
          children: [
            user.isLoggedIn
                ? ProviderDetailButton(
              title: "Add Review",
              icon: Icons.add,
              onTap: cubit.addReviewAction,
              isPrimary: true,
            )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 10,
            ),
            ProviderDetailDropdown<ReviewSorting>(
              items: const [
                ReviewSorting.newestFirst,
                ReviewSorting.oldestFirst,
                ReviewSorting.highestRating,
                ReviewSorting.lowestRating,
              ],
              selectedItem:cubit.reviewSorting,
              width: 150,
              // height: 3,
              onChanged:cubit.sortReviews,
            ),
          ],
        )
      ],
    );
  }
}
