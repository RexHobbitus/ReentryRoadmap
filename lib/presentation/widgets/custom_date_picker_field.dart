import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class CustomDatePickerField extends StatefulWidget {
  final DateTime? initialValue;
  double? bottomPadding;
  final Function(DateTime)? onChange;

  CustomDatePickerField({
    super.key,
    this.initialValue,
    this.onChange,
    this.bottomPadding,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  final textFieldKey = GlobalKey();
  DateTime _selectedDate = DateTime.now();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initialValue != null) {
      controller.text = DateFormat('MMM dd yyyy').format(widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: textFieldKey,
      controller: controller,
      disable: true,
      // initialValue: widget.initialValue,
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
          widget.onChange?.call(pickedDate);
        }
      },
    );
  }
}
