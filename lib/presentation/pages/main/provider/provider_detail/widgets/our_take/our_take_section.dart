import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class OurTakeSection extends StatelessWidget {
  const OurTakeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Our Rating",
              style: AppStyle.providerDetailTitle(context),
            ),
            const SizedBox(
              width: 10,
            ),
            _ourRating(context: context),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        _ceoInformation(context: context),
        const SizedBox(
          height: 20,
        ),
        _disclaimerWidget(context: context),
      ],
    );
  }

  Widget _ourRating({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Icon(
            Icons.star,
            size: 10,
            color: context.colorScheme.onSecondary,
          ),
          Text(
            " 4.2",
            style: context.textTheme.bodyMedium
                ?.copyWith(color: context.colorScheme.onSecondary),
          )
        ],
      ),
    );
  }

  Widget _ceoInformation({required BuildContext context}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(
              "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Danny Yoon",
              style: context.textTheme.bodyLarge,
            ),
            Text(
              "CEO of Dignifi",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.secondaryFixed
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _disclaimerWidget({required BuildContext context}) {
    return Container(
      width: context.sw,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: context.colorScheme.surfaceDim,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        _disclaimerText,
        style: context.textTheme.bodyMedium,
      ),
    );
  }

  final String _disclaimerText =
      '''Disclaimer: This is our opinions, meant to help you make a decision and not a factual disclaimer of the company. Our team has attempted to make it as accurate as possible at the time of publishing
  ''';
}
