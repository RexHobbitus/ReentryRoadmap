import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class CustomDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  double? bottomPadding;

  CustomDatePickerField({
    super.key,
    required this.controller,
    this.bottomPadding,
  });

  final textFieldKey = GlobalKey();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 16),
      child: TextField(
        key: textFieldKey,
        controller: controller,
        decoration: AppStyle.textFieldDecoration(
          context,
          suffix: const Padding(
            padding: EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
            child: Icon(Icons.keyboard_arrow_down_outlined),
          ),
        ),
        onTap: () async {
          final pickedDate = await showWebDatePicker(
              context: textFieldKey.currentContext!,
              initialDate: _selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 7)),
              lastDate: DateTime.now().add(const Duration(days: 14000)),
              width: 300,

              //withoutActionButtons: true,
              //weekendDaysColor: Colors.red,
              selectedDayColor: context.colorScheme.secondary
              //firstDayOfWeekIndex: 1,
              );
          if (pickedDate != null) {
            _selectedDate = pickedDate;
            controller.text = DateFormat('MMM dd yyyy').format(pickedDate);
          }
        },
      ),
    );
  }

  _borderStyle(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: context.colorScheme.tertiaryContainer,
        width: 1.5,
      ),
    );
  }
}
