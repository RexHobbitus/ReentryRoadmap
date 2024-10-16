import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_star_rating.dart';

class CustomerReviewWidget extends StatelessWidget {
  const CustomerReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context,constraints,deviceSize) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _customerInfo(context: context),
              _customerRating(context: context),
              Text(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum.",
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int index = 0; index < 5; index++)
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child:  CustomCachedImage(
                          height: deviceSize==DeviceSize.web?200:100,
                          width: deviceSize==DeviceSize.web?350:100,

                          imgUrl:
                              "https://assets.contenthub.wolterskluwer.com/api/public/content/4694a4818e6145d8acc16aea57d4bd43?v=521142e3",
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
      }
    );
  }

  Widget _customerInfo({required BuildContext context}) {
    return Row(
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
              "Allen Walker",
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "Sep 13, 2024",
              style: context.textTheme.bodySmall
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
              " Verified User",
              style: context.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  Widget _customerRating({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const CustomStarRating(),
          Text(
            "(4.5)",
            style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.secondary,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
