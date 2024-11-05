import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class CustomStarRating extends StatelessWidget {
  final bool disableTap;
  final Function(double)? onChange;
  final double? initialValue;
  const CustomStarRating({super.key,this.disableTap=true,this.onChange,this.initialValue});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialValue??5,
      minRating: 1,
      direction: Axis.horizontal,
      ignoreGestures: disableTap,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: context.colorScheme.secondary,
      ),
      // unratedColor for rating widget
      unratedColor:context.colorScheme.tertiaryContainer,
      onRatingUpdate: (rating) {
        print(rating);
        onChange?.call(rating);
      },
    );
  }
}
