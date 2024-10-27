import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'dart:math' as math;

import 'package:reentry_roadmap/domain/entities/provider.dart'; // import this

class RatingSubSection extends StatelessWidget {
  final Provider provider;
  const RatingSubSection({super.key,required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _overAllRatingInfo(context: context),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            children: [
              _detailRatingInfo(context, title: "5 Stars", value: provider.ratingCount?.i5),
              _detailRatingInfo(context, title: "4 Stars", value: provider.ratingCount?.i4),
              _detailRatingInfo(context, title: "3 Stars", value: provider.ratingCount?.i3),
              _detailRatingInfo(context, title: "2 Stars", value: provider.ratingCount?.i2),
              _detailRatingInfo(context, title: "1 Stars", value:provider.ratingCount?.i1),


            ],
          ),
        )
      ],
    );
  }

  Widget _overAllRatingInfo({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(color: context.themeData.cardColor),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height:120,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _dualStar(context: context),
                Text(
                  " ${provider.avgRating} ",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: _dualStar(context: context)),
              ],
            ),
            Text(
              "${provider.totalReviews} Reviews",
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dualStar({required BuildContext context}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: context.colorScheme.secondary,
        ),
        Icon(
          Icons.star,
          size: 25,
          color: context.colorScheme.secondary,
        ),
      ],
    );
  }

  Widget _detailRatingInfo(BuildContext context,
      {String? title, int? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toString(),
            style: context.textTheme.bodySmall
                ?.copyWith(color: context.colorScheme.tertiary),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: _CustomLinearProgressBar(
              value: value?.toDouble()??0,
            ),
          )
        ],
      ),
    );
  }
}

class _CustomLinearProgressBar extends StatelessWidget {
  final double value;

  const _CustomLinearProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value / 5, // Normalize value to 0.0 - 1.0
      backgroundColor:
          context.colorScheme.tertiaryContainer.withOpacity(0.2),
      color: context.colorScheme.secondary,
      minHeight: 6.0, // Adjust height as needed
    );
  }
}
