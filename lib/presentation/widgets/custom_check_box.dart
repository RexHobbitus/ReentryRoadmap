import 'package:flutter/material.dart';

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
    super.initState();
    _initialValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 35,
          child: Checkbox(
              value: _initialValue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: (val) {
                setState(() {
                  _initialValue = val ?? false;
                  widget.onChange?.call(_initialValue);
                });
              }),
        ),
        Text(widget.text ?? "None")
      ],
    );
  }
}
