import 'package:reentry_roadmap/domain/entities/incarceration_info.dart';

class IncarcerationInfoJson {
  String? idNumber;
  String? numberOfTimesIncarcerated;
  String? incarceratedHistory;
  String? latestOffenceType;
  String? lengthOfLongestIncarceration;
  String? lengthOfLatestIncarceration;
  String? firstIncarcerationDate;
  String? latestReleaseDate;
  String? mostRecentTermServerIn;
  List<String>? programAttendedWhileIncarcerated;

  IncarcerationInfoJson({
    this.idNumber,
    this.numberOfTimesIncarcerated,
    this.incarceratedHistory,
    this.latestOffenceType,
    this.lengthOfLongestIncarceration,
    this.lengthOfLatestIncarceration,
    this.firstIncarcerationDate,
    this.latestReleaseDate,
    this.mostRecentTermServerIn,
    this.programAttendedWhileIncarcerated,
  });

  IncarcerationInfoJson.fromJson(Map<String, dynamic> json) {
    idNumber = json['idNumber'];
    numberOfTimesIncarcerated = json['numberOfTimesIncarcerated'];
    incarceratedHistory = json['incarceratedHistory'];
    latestOffenceType = json['latestOffenceType'];
    lengthOfLongestIncarceration = json['lengthOfLongestIncarceration'];
    lengthOfLatestIncarceration = json['lengthOfLatestIncarceration'];
    firstIncarcerationDate = json['firstIncarcerationDate'];
    latestReleaseDate = json['latestReleaseDate'];
    mostRecentTermServerIn = json['mostRecentTermServerIn'];
    programAttendedWhileIncarcerated =
        json['programAttendedWhileIncarcerated'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['idNumber'] = this.idNumber;
    data['numberOfTimesIncarcerated'] = this.numberOfTimesIncarcerated;
    data['incarceratedHistory'] = this.incarceratedHistory;
    data['latestOffenceType'] = this.latestOffenceType;
    data['lengthOfLongestIncarceration'] = this.lengthOfLongestIncarceration;
    data['lengthOfLatestIncarceration'] = this.lengthOfLatestIncarceration;
    data['firstIncarcerationDate'] = this.firstIncarcerationDate;
    data['latestReleaseDate'] = this.latestReleaseDate;
    data['mostRecentTermServerIn'] = this.mostRecentTermServerIn;
    data['programAttendedWhileIncarcerated'] =
        this.programAttendedWhileIncarcerated;
    return data;
  }

  IncarcerationInfo toDomain() {
    return IncarcerationInfo(
      idNumber: idNumber,
      numberOfTimesIncarcerated: numberOfTimesIncarcerated,
      incarceratedHistory: incarceratedHistory,
      latestOffenceType: latestOffenceType,
      lengthOfLongestIncarceration: lengthOfLongestIncarceration,
      lengthOfLatestIncarceration: lengthOfLatestIncarceration,
      firstIncarcerationDate: firstIncarcerationDate,
      latestReleaseDate: latestReleaseDate,
      mostRecentTermServerIn: mostRecentTermServerIn,
      programAttendedWhileIncarcerated: programAttendedWhileIncarcerated,
    );
  }

  // CopyWith method
  IncarcerationInfoJson copyWith({
    String? idNumber,
    String? numberOfTimesIncarcerated,
    String? incarceratedHistory,
    String? latestOffenceType,
    String? lengthOfLongestIncarceration,
    String? lengthOfLatestIncarceration,
    String? firstIncarcerationDate,
    String? latestReleaseDate,
    String? mostRecentTermServerIn,
    List<String>? programAttendedWhileIncarcerated,
  }) {
    return IncarcerationInfoJson(
      idNumber: idNumber ?? this.idNumber,
      numberOfTimesIncarcerated: numberOfTimesIncarcerated ?? this.numberOfTimesIncarcerated,
      incarceratedHistory: incarceratedHistory ?? this.incarceratedHistory,
      latestOffenceType: latestOffenceType ?? this.latestOffenceType,
      lengthOfLongestIncarceration: lengthOfLongestIncarceration ?? this.lengthOfLongestIncarceration,
      lengthOfLatestIncarceration: lengthOfLatestIncarceration ?? this.lengthOfLatestIncarceration,
      firstIncarcerationDate: firstIncarcerationDate ?? this.firstIncarcerationDate,
      latestReleaseDate: latestReleaseDate ?? this.latestReleaseDate,
      mostRecentTermServerIn: mostRecentTermServerIn ?? this.mostRecentTermServerIn,
      programAttendedWhileIncarcerated: programAttendedWhileIncarcerated ?? this.programAttendedWhileIncarcerated,
    );
  }
}