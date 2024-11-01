import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_star_rating.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomerReviewWidget extends StatelessWidget {
  final ProviderReview review;

  const CustomerReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customerInfo(context: context),
            _customerRating(context: context),
            Text(
              "${review.review}",
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            review.images!.isEmpty
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int index = 0;
                            index < review.images!.length;
                            index++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomCachedImage(
                              height: deviceSize == DeviceSize.web ? 200 : 100,
                              width: deviceSize == DeviceSize.web ? 350 : 100,
                              imgUrl: review.images![index],
                              radius: 10,
                            ),
                          )
                      ],
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            ProviderDetailButton(
              title: " Like",
              icon: Icons.thumb_up_alt_outlined,
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }

  Widget _customerInfo({required BuildContext context}) {
    return review.uploadedBy==null?const SizedBox.shrink():FutureBuilder<AppUser>(
      future: getIt<AppUserRepository>().getUserFromId(id: review.uploadedBy!),
      builder: (context, userData) {
        return Skeletonizer(
          enabled: !userData.hasData,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${userData.data?.onboardingInfo?.personalInfo?.firstName} ${userData.data?.onboardingInfo?.personalInfo?.lastName}",
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    "${review.createdAt}",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: context.colorScheme.tertiary),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.verified),
                  Text(
                    "  Verified User",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.secondaryFixed
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _customerRating({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CustomStarRating(
            initialValue: review.rating,
          ),
          Text(
            " (${review.rating})",
            style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.secondary),
          )
        ],
      ),
    );
  }
}
