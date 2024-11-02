import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class ReviewWebSearchField extends StatelessWidget {
  const ReviewWebSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Container(
         // padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: context.themeData.cardColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: TextEditingController(),
                hint: "Search for a Service",
                width: constraints.maxWidth*0.3,
                bottomPadding: 0,
                textFieldMode: TextFieldMode.search,
              ),
              const SizedBox(
                width: 10,
                height: 30,
                child: VerticalDivider(
                  thickness: 2,
                ),
              ),
              CustomTextField(
                controller: TextEditingController(),
                hint: "Enter Location",
                suffixPath: Assets.search,
                width: constraints.maxWidth*0.325,
                bottomPadding: 0,
                textFieldMode: TextFieldMode.search,
              ),
            ],
          ),
        );
      }
    );
  }
}
