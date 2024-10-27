import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class ExploreMobileSearchField extends StatelessWidget {
  const ExploreMobileSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {
          return CustomTextField(
            controller: TextEditingController(),
            hint: "Search",
            bottomPadding: 0,
            suffixPath: Assets.search,
            textFieldMode: TextFieldMode.search,
          );
        }
    );
  }
}
