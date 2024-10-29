import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class ExploreFooterSection extends StatelessWidget {
  const ExploreFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: context.themeData.cardColor,
      child: Column(
        children: [
          _companyProfileSection(context: context),
          const SizedBox(
            height: 42,
          ),
          Text(
            _aboutUs,
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          _disclaimerWidget(context: context),
          const SizedBox(
            height: 30,
          ),
          _ceoInformation(context: context),
        ],
      ),
    );
  }

  _companyProfileSection({required BuildContext context}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.secondary,
          radius: 35,
          child: SvgPicture.asset(
            Assets.openGate,
            height: 20,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Our Rating",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: context.colorScheme.secondaryFixed),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: context.colorScheme.secondary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "4.2",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: context.colorScheme.secondaryFixed),
                ),
              ],
            ),
            Text(
              "OpenGate Oakland",
              style: context.textTheme.titleMedium,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "View OpenGate Oakland >",
                style: context.textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: context.colorScheme.primary),
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
          color: context.colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Text(_disclaimerText, style: context.textTheme.bodyMedium),
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
                color: context.colorScheme.secondary,
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        _navigationButtons(context: context),
      ],
    );
  }

  Widget _navigationButtons({required BuildContext context}) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: context.colorScheme.primary.withOpacity(0.3),
            radius: 20,
            child: Icon(
              Icons.arrow_back,
              color: context.colorScheme.onSecondary,
            )),
        const SizedBox(
          width: 6,
        ),
        CircleAvatar(
          backgroundColor: context.colorScheme.primary,
          radius: 20,
          child: Icon(
            Icons.arrow_forward,
            color: context.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }

  final String _aboutUs =
      '''It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader.
  ''';

  final String _disclaimerText =
      '''Disclaimer: This is our opinions, meant to help you make a decision and not a factual disclaimer of the company. Our team has attempted to make it as accurate as possible at the time of publishing
  ''';
}
