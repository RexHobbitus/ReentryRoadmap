import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

import '../../../../widgets/custom_textfield.dart';

class ProfileViewTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final bool? readOnly, isDetail;
  final bool? hide;
  final double? bottomPadding;
  final String? label;

  const ProfileViewTextField({
    super.key,
    required this.title,
    this.controller,
    this.hint,
    this.onChange,
    this.onSubmit,
    this.readOnly = true,
    this.hide,
    this.bottomPadding,
    this.label,
    this.isDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 8),
          child: Text(
            title,
            style: context.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CustomTextField(
          controller: controller,
          hint: hint,
          onChange: onChange,
          onSubmit: onSubmit,
          readOnly: readOnly,
          hide: hide,
          bottomPadding: bottomPadding,
          label: label,
          isDetail: isDetail ?? false,
        ),
      ],
    );
  }
}
