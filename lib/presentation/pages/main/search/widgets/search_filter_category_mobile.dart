import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class SearchFilterCategoryMobile extends StatelessWidget {
  final String title;
  final List<String> list;
  final List<String> selectedList;
  final Function(String value) onSelect;

  const SearchFilterCategoryMobile({
    super.key,
    required this.title,
    required this.list,
    required this.selectedList,
    required this.onSelect,
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
                isSelected: selectedList.contains(category),
                onSelect: onSelect,
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
  final Function(String value) onSelect;

  const _CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect.call(title),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? context.colorScheme.secondary : context.colorScheme.surfaceContainer,
        ),
        child: Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
              color: isSelected ? context.colorScheme.onSecondary : context.colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 10),
        ),
      ),
    );
  }
}
