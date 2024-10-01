import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class CustomDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  CustomDatePickerField({super.key,required this.controller});

  final textFieldKey = GlobalKey();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: textFieldKey,
      controller: controller,
      decoration: InputDecoration(
        
        hintStyle: context.textTheme.bodyMedium
            ?.copyWith(color: context.themeData.colorScheme.tertiary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintFadeDuration: const Duration(milliseconds: 500),
        isDense: true,
        hoverColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        fillColor: context.themeData.cardColor,
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
        enabledBorder:  _borderStyle(context),
        focusedBorder:_borderStyle(context),
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
          controller.text =DateFormat('MMM dd yyyy').format(pickedDate);
        }
      },
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
