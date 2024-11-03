import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class SearchMobileField extends StatelessWidget {
  const SearchMobileField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: TextEditingController(),
      hint: "Search",
      suffixPath: Assets.search,
      textFieldMode: TextFieldMode.search,
      height: 60,
    );
  }
}
