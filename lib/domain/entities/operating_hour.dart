import 'package:equatable/equatable.dart';

class OperatingHour extends Equatable {
  final String day;
  DateTime? startTime;
  DateTime? endTime;

  OperatingHour({
    required this.day,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  static OperatingHour fromJson(Map<String, dynamic> json) {
    return OperatingHour(
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        day,
        startTime,
        endTime,
      ];
}
