import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class SearchFilterCategoryMobile extends StatelessWidget {
  final String title;
  final List<String> list;
  final List<String> selectedList;

  const SearchFilterCategoryMobile({
    super.key,
    required this.title,
    required this.list,
    required this.selectedList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (var category in List.from(list).toList())
              _CategoryChip(
                title: category,
                isSelected: false,
              ),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;

  const _CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? context.colorScheme.secondary : context.colorScheme.surfaceContainer,
          ),
          child: Center(
            child: Text(
              title,
              style: context.textTheme.bodySmall?.copyWith(
                  color: isSelected ? context.colorScheme.onSecondary : context.colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
