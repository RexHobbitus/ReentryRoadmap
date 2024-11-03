import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class SearchFilterCategoryWeb extends StatelessWidget {
  final String title;
  final List<String> list;
  final List<String> selectedList;
  final Function() onMore;

  const SearchFilterCategoryWeb({
    super.key,
    required this.title,
    required this.list,
    required this.selectedList,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ...List.generate(
          min(5, list.length),
          (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      value: index % 2 == 0,
                      onChanged: (value) {},
                      checkColor: Colors.transparent,
                      activeColor: context.colorScheme.secondary,
                      side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      list[index],
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (list.length > 5) ...[
          InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: onMore,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_rounded,
                  size: 16,
                  color: context.colorScheme.onSurface.withOpacity(0.5),
                ),
                Text(
                  "More",
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          )
        ]
      ],
    );
  }
}
