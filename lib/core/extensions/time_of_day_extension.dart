import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  DateTime toDateTime({DateTime? date}) {
    date ??= DateTime.now();
    return DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
  }
}
