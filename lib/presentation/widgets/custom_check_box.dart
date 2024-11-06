import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final String? text;
  final Function(bool)? onChange;

  const CustomCheckBox({
    super.key,
    this.value = false,
    this.text,
    this.onChange,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _initialValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          child: Checkbox(
              value: _initialValue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              onChanged: (val) {
                setState(() {
                  _initialValue = val ?? false;
                  widget.onChange?.call(_initialValue);
                });
              }),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.text ?? "None",
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.tertiary),
        )
      ],
    );
  }
}
