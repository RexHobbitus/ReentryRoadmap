import 'package:go_router/go_router.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/search_field/review_mobile_search_field.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/search_field/review_web_search_field.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

import '../../../../../core/utils/constants.dart';
import '../../user_reviews/user_reviews_page.dart';

class ReviewSearchSection extends StatelessWidget {
  final ReviewCubit cubit;

  const ReviewSearchSection({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            constraints.maxWidth < kMenuBreakPoint
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Write a Review",
                            style: context.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Search for a provider to review",
                            style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.themeData.colorScheme.tertiary),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: "Your Reviews",
                        width: constraints.maxWidth > 350
                            ? 100
                            : constraints.maxWidth,
                        height: constraints.maxHeight > 350
                            ? 30
                            : constraints.maxHeight,
                        onTap: () {
                          GoRouter.of(context).go(UserReviews.path);
                        },
                      )
                    ],
                  )
                : SizedBox(
                    width: constraints.maxWidth > kMenuBreakPoint
                        ? constraints.maxWidth * 0.35
                        : null,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Write a Review",
                          style: context.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Search for a provider to review",
                          style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.themeData.colorScheme.tertiary),
                        ),
                      ],
                    ),
                ),
            constraints.maxWidth > kMenuBreakPoint
                ? const ReviewWebSearchField()
                : ReviewMobileSearchField(),
            SizedBox(
              height: 20,
            ),
            constraints.maxWidth > kMenuBreakPoint
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Providers you've recently viewed",
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    CustomButton(
                        text: "Your Reviews",
                        width: constraints.maxWidth > 350
                            ? 100
                            : constraints.maxWidth,
                        height: constraints.maxHeight > 350
                            ? 45
                            : constraints.maxHeight,
                        onTap: () {
                    GoRouter.of(context).go(UserReviews.path);                        },
                      ),

                  ],
                ) : Text(
              "Providers you've recently viewed",
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        );
      }),
    );
  }
}
