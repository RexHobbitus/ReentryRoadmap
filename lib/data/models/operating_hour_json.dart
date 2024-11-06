import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/domain/entities/operating_hour.dart';

class OperatingHourJson {
  final String day;
   Timestamp? startTime;
   Timestamp? endTime;

  OperatingHourJson({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  static OperatingHourJson fromJson(Map<String, dynamic> json) {
    return OperatingHourJson(
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  OperatingHour toDomain() {
    return OperatingHour(
      day: day,
      startTime: startTime?.toDate(),
      endTime: endTime?.toDate(),
    );
  }
}
