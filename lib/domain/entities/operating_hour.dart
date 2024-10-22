class OperatingHour {
  String? day;
  DateTime? startTime;
  DateTime? endTime;

  OperatingHour({
    this.day,
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

   OperatingHour.shimmer() {
    day="Test";
    startTime=DateTime.now();
    endTime=DateTime.now();
  }
}
