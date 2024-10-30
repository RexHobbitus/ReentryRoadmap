import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String? label;
  final List<T> items;
  final T? selectedItem;
  final Function(T?)? onChange;
  final double? height;
  final double? width;
  final double? bottomPadding;
  const CustomDropDown({
    super.key,
    this.label,
    required this.items,
    this.selectedItem,
    required this.onChange,
    this.height,
    this.width,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding ?? 16),
        child: CustomDropdown<T>(
          hintText: '--State--',
          items: items,
          initialItem: selectedItem,
          excludeSelected: false,
          maxlines: 1,
          hintBuilder: (context, value, _) {
            return Text(
              label ?? "",
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onSurface,
              ),
            );
          },
          closedHeaderPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          expandedHeaderPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: CustomDropdownDecoration(
            listItemStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurface,
            ),
            closedFillColor: Colors.transparent,
            expandedFillColor: Theme.of(context).colorScheme.background,
            closedBorder: Border.all(
                color: context.colorScheme.tertiaryContainer, width: 1.5),
            expandedBorder: Border.all(
                color: context.colorScheme.tertiaryContainer, width: 1.5),
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
