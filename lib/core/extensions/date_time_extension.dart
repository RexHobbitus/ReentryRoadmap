import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime? {

  String toTimeAMPM() {
    if(this==null){
      return "---";
    }
    final hours = this!.hour % 12;
    final minutes = this!.minute.toString().padLeft(2, '0');
    final amOrPm = this!.hour < 12 ? 'AM' : 'PM';
    return '$hours:$minutes $amOrPm';
  }
  String toMonthDateYear() {
    if(this==null){
      return "---";
    }
    return DateFormat('MMM dd yyyy').format(this!);
  }


}