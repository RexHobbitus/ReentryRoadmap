import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String? label;
  final List<T> items;
  final T? selectedItem;
  final Function(T?)? onChange;
  const CustomDropDown(
      {super.key, this.label, required this.items, this.selectedItem,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomDropdown<T>(
        hintText: '--Select--',
        items: items,
        initialItem: selectedItem,
        excludeSelected: false,
        closedHeaderPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: CustomDropdownDecoration(
          closedFillColor: Colors.transparent,
          expandedFillColor: Theme.of(context).colorScheme.background,
          closedBorder: Border.all(color: context.colorScheme.tertiaryContainer,width: 1.5),
          expandedBorder: Border.all(color: context.colorScheme.tertiaryContainer,width: 1.5),
        ),
        onChanged:onChange,
      ),
    );
  }
}