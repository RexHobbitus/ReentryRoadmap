import 'package:equatable/equatable.dart';

class IncarcerationInfo extends Equatable {
  String? idType;
  String? idNumber;

  String? numberOfTimesIncarcerated;
  String? incarceratedHistory;
  List<String>? latestOffenceType;
  String? lengthOfLongestIncarceration;
  String? lengthOfLatestIncarceration;
  DateTime? firstIncarcerationDate;
  DateTime? latestReleaseDate;
  String? mostRecentTermServerIn;
  List<String>? programAttendedWhileIncarcerated;

  IncarcerationInfo(
      {this.idType,
      this.idNumber,
      this.numberOfTimesIncarcerated,
      this.incarceratedHistory,
      this.latestOffenceType,
      this.lengthOfLongestIncarceration,
      this.lengthOfLatestIncarceration,
      this.firstIncarcerationDate,
      this.latestReleaseDate,
      this.mostRecentTermServerIn,
      this.programAttendedWhileIncarcerated});

  IncarcerationInfo.fromJson(Map<String, dynamic> json) {
    idType = json['idType'];
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
        json['programAttendedWhileIncarcerated']?.cast<String>()?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idType'] = this.idType;
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

  IncarcerationInfo copyWith({
    String? idType,
    String? idNumber,
    String? numberOfTimesIncarcerated,
    String? incarceratedHistory,
    List<String>? latestOffenceType,
    String? lengthOfLongestIncarceration,
    String? lengthOfLatestIncarceration,
    DateTime? firstIncarcerationDate,
    DateTime? latestReleaseDate,
    String? mostRecentTermServerIn,
    List<String>? programAttendedWhileIncarcerated,
  }) {
    return IncarcerationInfo(
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
      numberOfTimesIncarcerated:
          numberOfTimesIncarcerated ?? this.numberOfTimesIncarcerated,
      incarceratedHistory: incarceratedHistory ?? this.incarceratedHistory,
      latestOffenceType: latestOffenceType ?? this.latestOffenceType,
      lengthOfLongestIncarceration:
          lengthOfLongestIncarceration ?? this.lengthOfLongestIncarceration,
      lengthOfLatestIncarceration:
          lengthOfLatestIncarceration ?? this.lengthOfLatestIncarceration,
      firstIncarcerationDate:
          firstIncarcerationDate ?? this.firstIncarcerationDate,
      latestReleaseDate: latestReleaseDate ?? this.latestReleaseDate,
      mostRecentTermServerIn:
          mostRecentTermServerIn ?? this.mostRecentTermServerIn,
      programAttendedWhileIncarcerated: programAttendedWhileIncarcerated ??
          this.programAttendedWhileIncarcerated,
    );
  }

  @override
  List<Object?> get props => [
        idType,
        idNumber,
        numberOfTimesIncarcerated,
        incarceratedHistory,
        latestOffenceType,
        lengthOfLongestIncarceration,
        lengthOfLatestIncarceration,
        firstIncarcerationDate,
        latestReleaseDate,
        mostRecentTermServerIn,
        programAttendedWhileIncarcerated,
      ];
}
