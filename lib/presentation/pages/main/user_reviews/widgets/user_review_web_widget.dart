import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../widgets/custom_star_rating.dart';

class UserReviewWebCard extends StatefulWidget {
  final String organization;
  final String title;
  final String date;
  final double rating;
  final String review;
  final List<dynamic> imageUrl;

  const UserReviewWebCard({
    super.key,
    required this.organization,
    required this.title,
    required this.date,
    required this.rating,
    required this.review,
    required this.imageUrl,
  });

  @override
  State<UserReviewWebCard> createState() => _UserReviewWebCardState();
}

class _UserReviewWebCardState extends State<UserReviewWebCard> {
  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context, constraints, deviceSize) {
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: context.themeData.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: context.themeData.colorScheme.tertiaryContainer,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          widget.organization,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.themeData.colorScheme.secondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 8,
                        color: context.themeData.colorScheme.secondary,
                      )
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    widget.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.date,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.themeData.colorScheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _ratingWidget(),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 800,
                    child: Text(
                      widget.review,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.themeData.colorScheme.secondary,

                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildImages(),
                ],
              ),

            ],
          ),
        );
      },
    );
  }

  Widget _ratingWidget() {
    return Row(
      children: [
        CustomStarRating(
          disableTap: true,
          initialValue: widget.rating,
          onChange: (val) {},
        ),
        const SizedBox(width: 5),
        Text(
          "(${widget.rating})",
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Widget to build images in a row
  Widget _buildImages() {
    return Wrap(
      spacing: 8, // Space between images
      runSpacing: 8, // Space between rows if it wraps
      children: widget.imageUrl.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            url,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}
