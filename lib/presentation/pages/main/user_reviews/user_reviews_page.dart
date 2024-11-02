import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_initial.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/widgets/user_review_web_widget.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/widgets/user_review_widget.dart';

import '../../../../../core/utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../review/review_page.dart';

/// change the organization name , title to real variable data after editing the database

class UserReviews extends StatefulWidget {
  final UserReviewsCubit cubit;
  final UserReviewsInitialParams initialParams;

  static const path = '/UserReviews';

  const UserReviews({
    Key? key,
    required this.initialParams,
    required this.cubit,
  }) : super(key: key);

  @override
  State<UserReviews> createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  UserReviewsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
    cubit.fetchUserReviews(); // Fetch reviews on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserReviewsState>(
        future: fetchUserReviewsState(), // Fetch the reviews state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final state = snapshot.data;

          // If the user is not logged in
          if (state == null || state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.reviews!.isEmpty) {
            return const Center(child: Text('No reviews found.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  constraints.maxWidth > kMenuBreakPoint
                      ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Reviews",
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              CustomButton(
                                text: "+ Add Review",
                                width: constraints.maxWidth > 350
                                    ? 100
                                    : constraints.maxWidth,
                                height: constraints.maxHeight > 350
                                    ? 45
                                    : constraints.maxHeight,
                                onTap: () {
                                  GoRouter.of(context).go(ReviewPage.path);
                                },
                              ),
                            ],
                          ),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Your Reviews",
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            CustomButton(
                              text: "+ Add Review",
                              width: constraints.maxWidth > 350
                                  ? 100
                                  : constraints.maxWidth,
                              height: constraints.maxHeight > 350
                                  ? 45
                                  : constraints.maxHeight,
                              onTap: () {
                                GoRouter.of(context).go(ReviewPage.path);
                              },
                            ),
                          ],
                        ),
                      ),
                  SizedBox(height: 10,),
                  //ToDO: change the organization name , title to real variable data after editing the database
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.reviews?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final review = state.reviews?[index];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: constraints.maxWidth < kMenuBreakPoint
                              ? UserReviewCard(
                                  organization: "Opengate Foundation",
                                  title: "OpenGate Hayward",
                                  review: review?.review ?? "Review",
                                  rating: review?.rating ?? 0,
                                  date: cubit.formatDate(review!.uploadTime),
                                  imageUrl: review.images,
                                )
                              : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: UserReviewWebCard(
                                    organization: "Opengate Foundation",
                                    title: "OpenGate Hayward",
                                    date: cubit.formatDate(review!.uploadTime),
                                    rating: review.rating,
                                    review: review.review,
                                    imageUrl: review.images),
                              ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<UserReviewsState> fetchUserReviewsState() async {
    // Wait for the cubit to fetch user reviews and return the latest state
    await cubit.fetchUserReviews();
    return cubit.state; // Assuming the cubit maintains the current state
  }
}
