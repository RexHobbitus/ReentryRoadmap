import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class ProviderDetailDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final Function(T?)? onChanged;
  final double width;
  final double? height;

  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;

  const ProviderDetailDropdown({
    Key? key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.width = 120,
    this.height,
    // Default width
    this.borderRadius = 5.0, // Default border radius
    this.contentPadding = const EdgeInsets.symmetric(vertical: 4, horizontal: 10), // Default padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: DropdownButtonFormField<T>(
          decoration: InputDecoration(
            fillColor: context.colorScheme.tertiary.withOpacity(0.2),
            filled: true,
            isDense: true,
            contentPadding: contentPadding,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          value: selectedItem,
          items: items
              .map((item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              style: context.textTheme.bodyMedium,
            ),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
