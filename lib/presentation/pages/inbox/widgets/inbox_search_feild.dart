import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../widgets/custom_textfield.dart';

class InboxSearchField extends StatelessWidget {
  const InboxSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomTextField(
        controller: TextEditingController(),
        hint: "Search",
        bottomPadding: 0,
        suffixPath: Assets.search,
        textFieldMode: TextFieldMode.search,
      );
    });
  }
}
