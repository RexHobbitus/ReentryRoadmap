import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';

class SearchCategoriesMenu extends StatelessWidget {
  const SearchCategoriesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int toShow = 0;
        final isBigScreen = constraints.maxWidth > kMenuBreakPoint;

        List<double> itemWidths = kServiceCategories.map((item) {
          final textPainter = TextPainter(
            text: TextSpan(text: item.title, style: isBigScreen ? context.textTheme.labelLarge : context.textTheme.labelMedium),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          )..layout();
          return textPainter.width + 16; // Add padding
        }).toList();

        double requiredWidth = 0.0;
        const moreButtonWidth = 50;
        double availableWidth = constraints.maxWidth - moreButtonWidth;

        for (int i = 0; i < itemWidths.length; i++) {
          requiredWidth = requiredWidth + itemWidths[i] + (isBigScreen ? 50 : 20);
          if (requiredWidth < availableWidth) {
            toShow = i + 1;
          } else {
            break;
          }
        }

        List<ServiceCategory> moreMenuItems = kServiceCategories.skip(toShow).toList();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              toShow * 2,
              (tempIndex) {
                final index = tempIndex ~/ 2;
                if (tempIndex % 2 == 0) {
                  return Text(
                    kServiceCategories[index].title,
                    style: (isBigScreen ? context.textTheme.labelLarge : context.textTheme.labelMedium)?.copyWith(fontWeight: FontWeight.w600),
                  );
                }
                return SizedBox(width: isBigScreen ? 50 : 20);
              },
            ),
            PopupMenuButton<ServiceCategory>(
              style: const ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateColor.transparent,
                shadowColor: WidgetStateColor.transparent,
                foregroundColor: WidgetStateColor.transparent,
              ),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      'More',
                      style: (isBigScreen ? context.textTheme.labelLarge : context.textTheme.labelMedium)?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
              onSelected: (ServiceCategory item) {
                print('$item clicked from More');
              },
              itemBuilder: (BuildContext context) {
                return List.generate(
                  moreMenuItems.length,
                  (index) {
                    final item = moreMenuItems[index];
                    return PopupMenuItem<ServiceCategory>(
                      height: 50,
                      value: item,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (index != moreMenuItems.length - 1) const SizedBox(height: 1),
                          SizedBox(
                            height: 49,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.title,
                              ),
                            ),
                          ),
                          if (index != moreMenuItems.length - 1) const Divider(height: 1),
                        ],
                      ),
                    );
                  },
                );
                return moreMenuItems
                    .map(
                      (item) => PopupMenuItem<ServiceCategory>(
                        value: item,
                        child: Text(item.title),
                      ),
                    )
                    .toList();
              },
            )
          ],
        );
      },
    );
  }
}
