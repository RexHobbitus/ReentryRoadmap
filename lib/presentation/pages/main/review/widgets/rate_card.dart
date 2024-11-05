import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/review_card.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_responsive_builder.dart';
import '../review_cubit.dart';
import '../review_navigator.dart';

class RateCard extends StatefulWidget {
  final String title;
  ReviewNavigator navigator;

  RateCard({super.key, required this.title, required this.navigator});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  final List<String> _questions = [
    'My physical environment felt modern, clean and uplifting',
    'I was exposed to people who were inspiring and positive',
    'I was around people who were involved in gangs and drugs',
    'I had access to mentorship and other growth opportunities',
    'I felt inspired to live a meaningful life',
    'I felt loved and supported by the people around me'
  ];

  late Map<String, int> _ratings;

  @override
  void initState() {
    super.initState();
    _ratings = {for (var question in _questions) question: 0};
  }

  bool get _allRatingsSelected {
    return _ratings.values.every((rating) => rating != 0);
  }

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return SizedBox(
        width: deviceSize == DeviceSize.web ? 1000 : null,
        height: deviceSize == DeviceSize.web
            ? 520
            : MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              constraints.maxWidth > kMenuBreakPoint
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(Assets.verified),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close))
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(Assets.verified),
                      ],
                    ),
              Divider(color: context.themeData.colorScheme.secondary),
              const SizedBox(height: 10),
              const Text(
                "Reflecting on your experience with this provider, how much would you agree with the following statements? Rank your experience on a scale of 1-5 where 1 represents 'disagree' and 5 represents 'completely agree'.",
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox(height: 20),
              constraints.maxWidth < kMenuBreakPoint
                  ? Expanded(
                    child: ListView.separated(
                        itemCount: _questions.length,
                        itemBuilder: (context, index) {
                          String question = _questions[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(5, (i) {
                                  int ratingValue = i + 1;
                                  bool isSelected =
                                      _ratings[question] == ratingValue;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _ratings[question] = ratingValue;
                                        });
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? context.themeData.colorScheme
                                                  .secondary
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: context.themeData.colorScheme
                                                .secondary,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          ratingValue.toString(),
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : context.themeData.colorScheme
                                                    .secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        },
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      ),
                  )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView.separated(
                      itemCount: _questions.length - 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String question = _questions[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: List.generate(5, (i) {
                                int ratingValue = i + 1;
                                bool isSelected =
                                    _ratings[question] == ratingValue;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _ratings[question] = ratingValue;
                                      });
                                    },
                                    child: Container(
                                      width: 85,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? context.themeData.colorScheme
                                            .secondary
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: context.themeData.colorScheme
                                              .secondary,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        ratingValue.toString(),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : context.themeData.colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 30),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Flexible(
                    child: ListView.separated(
                      itemCount: _questions.length -3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String question = _questions[index+3];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: List.generate(5, (i) {
                                int ratingValue = i + 1;
                                bool isSelected =
                                    _ratings[question] == ratingValue;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _ratings[question] = ratingValue;
                                      });
                                    },
                                    child: Container(
                                      width: 85,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? context.themeData.colorScheme
                                            .secondary
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: context.themeData.colorScheme
                                              .secondary,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        ratingValue.toString(),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : context.themeData.colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: constraints.maxWidth > kMenuBreakPoint ? 73 : null,
                  child: ElevatedButton(
                    onPressed: _allRatingsSelected
                        ? () {
                            Navigator.pop(context);
                            widget.navigator.navigator.showDialogBox(
                                context,
                                ReviewCard(
                                  ratings: _ratings,
                                  title: widget.title,
                                ));
                          }
                        : null,
                    child: const Text("Write a Review"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
