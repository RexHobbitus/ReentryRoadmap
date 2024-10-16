import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'dart:math' as math; // import this

class RatingSubSection extends StatelessWidget {
  const RatingSubSection({super.key});

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
              _detailRatingInfo(context, title: "5 Stars", value: 4.0),
              _detailRatingInfo(context, title: "4 Stars", value: 5.0),
              _detailRatingInfo(context, title: "3 Stars", value: 1.0),
              _detailRatingInfo(context, title: "2 Stars", value: 2.0),
              _detailRatingInfo(context, title: "1 Stars", value: 3.0),


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
      child: Column(
        children: [
          Row(
            children: [
              _dualStar(context: context),
              Text(
                " 4.9 ",
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
            "235 Reviews",
            style: context.textTheme.bodySmall,
          ),
        ],
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
      {String? title, double? value}) {
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
              value: value ?? 0,
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
